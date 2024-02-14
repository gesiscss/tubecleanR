#' Parse YouTube Comments
#' This function processes a dataframe of YouTube comments, extracting and cleaning various elements such as emojis, smileys, URLs, timestamps, and user mentions. It supports comment dataframes created with the \code{\link[tuber]{get_all_comments}},\code{\link[tuber]{get_comments}} or \code{\link[vosonSML]{Collect}} functions.
#' @param data A dataframe containing YouTube comments. The structure of this dataframe should conform to the output of the 'tuber' or 'vosonSML' package.
#' @param package A character string specifying the package that was used to collect the comment data. The default value is "auto", which automatically detects the package based on the structure of the `data`. Other possible values are "tuber" and "vosonSML".
#' @param verbose A logical parameter. If TRUE, the function prints progress reports to the console.
#' @return A dataframe with the original comment data and additional columns for cleaned comments, emojis, emoji descriptions, smileys, URLs, timestamps, and user mentions. The dataframe also includes metadata as attributes, such as the origin package, tubecleanR version, and counts of comments, links, emojis, smileys, user mentions, and timestamps.
#' @importFrom stringi stri_split_boundaries stri_extract_all_regex stri_replace_all_regex
#' @importFrom anytime anytime
#' @importFrom qdapRegex rm_url rm_non_words
#' @importFrom utils packageVersion
#' @importFrom utils read.csv
#' @examples
#' # Loading example comments bundled with the package
#' tuber_comments <- readRDS(system.file("tuberComments.rds", package = "tubecleanR"))
#'
#' # parsing comments
#' parsed_comments <- parse_yt_comments(tuber_comments)
#' @export
#' @keywords youtube, comments, parsing
#' @note This function requires the 'tuber' or 'vosonSML' package for data collection. The 'tubecleanR' minipackage is only for processing.

parse_yt_comments <- function(data,
                              package = "auto",
                              verbose = FALSE){

  #### verifying inputs
  if (is.data.frame(data) == FALSE) {
    stop("The input 'data' must be a comment dataframe created with the tuber or vosonSML package.")
  }

  if (!(package == "tuber" | package == "vosonSML" | package == "auto")) {
    stop("The parameter 'package' must be a text string with the value 'auto', 'tuber' or 'vosonSML'.")
  }

  if (!(verbose == TRUE | verbose == FALSE)) {
    stop("The parameter 'verbose' must be 'TRUE' or 'FALSE'.")
  }

  #### Importing Emoji Dictionary
  EmojiDictionary <- read.csv(system.file("EmojiDictionary.csv", package = "tubecleanR"),
                              header = TRUE,
                              stringsAsFactors = FALSE,
                              strip.white = FALSE,
                              colClasses = "character",
                              blank.lines.skip = TRUE
  )

  # printing progress report
  if (verbose) {cat("Imported Emoji Dictionary \U2713 \n")}


  #### Importing Smiley Dictionary
  SmileyDictionary <- read.csv(system.file("SmileyDictionary.csv", package = "tubecleanR"),
                              header = TRUE,
                              stringsAsFactors = FALSE,
                              strip.white = FALSE,
                              colClasses = "character",
                              blank.lines.skip = TRUE
  )

  # printing progress report
  if (verbose) {cat("Imported Smiley Dictionary \U2713 \n")}

  # trimming down smilies for better regex
  SmileyVec <- trimws(SmileyDictionary[,2])

  #### Naming columns

  # auto-detecting the origin package by column names and adjusting accordingly
  if (package == "auto") {
    if (colnames(data)[1] == "channelId") {package <- "tuber"} else {package <- "vosonSML"}
  }

  # enable use with comments collected using vosonSML
  if (package == "vosonSML") {
    data <- data[,c("VideoID","AuthorDisplayName","Comment","LikeCount","PublishedAt","UpdatedAt","ParentID","CommentID")]
    names(data) <- c("videoId","authorDisplayName","textOriginal","likeCount","publishedAt","updatedAt","parentId","id")
  } else {
    # tuber data: only keep the relevant columns
    data <- data[,c("videoId","authorDisplayName","textOriginal","likeCount","publishedAt","updatedAt","parentId","id")]
  }


  # printing progress report
  if (verbose) {cat("Updated Column names to match specified format \U2713 \n")}

  #### Adapting to missing column

  # account for dataframes without "parentId" column (those scraped with get_comments() instead of get_all_comments() in tuber)
  if (is.null(data$parentId)) {
    parentId <- rep(NA,dim(data)[1])
    data <- cbind.data.frame(data,parentId)
  }

  #### Assigning proper class to columns

  # convert dataframe columns to proper types
  data$videoId <- as.character(data$videoId)
  data$authorDisplayName <- as.character(data$authorDisplayName)
  data$textOriginal <- as.character(data$textOriginal)
  data$likeCount <- as.numeric(data$likeCount)
  data$parentId <- as.character(data$parentId)
  data$id <- as.character(data$id)
  data$publishedAt <- anytime(data$publishedAt, asUTC = TRUE) #FIXME This takes a long time
  data$updatedAt <- anytime(data$updatedAt, asUTC = TRUE) #FIXME This takes a long time

  # printing progress report
  if (verbose) {cat("Assigned proper column classes \U2713 \n")}

  ## replacing \n with whitespace
  data$textOriginal <- gsub("\n", " ", data$textOriginal)


  #### Extracting variables of Interest ####

  #### Emoji
  # isolating emoji to get a better and faster matching than methods using stringr, stringi, rm_default or mgsub
  # (idea from: https://github.com/JBGruber/rwhatsapp/blob/master/R/emoji_lookup.R)
  CommentNumber <- 1:length(data$textOriginal)
  CharSplit <- stri_split_boundaries(data$textOriginal, type = "character")

  # creating split data frame
  SplitFrame <- data.frame(
    CommentNumber = rep(CommentNumber, sapply(CharSplit, length)),
    Emoji = unlist(CharSplit)
  )

  # doing the matching
  R.native <- EmojiDictionary$Desc[match(SplitFrame$Emoji, EmojiDictionary$R.native)]
  SplitFrame <- cbind.data.frame(SplitFrame, R.native)

  # deleting empties
  SplitFrame <- SplitFrame[!is.na(SplitFrame$R.native), ]

  # creating list of vectors for emoji descriptions and glyphs
  EmojiSplitNames <- split(SplitFrame$R.native, SplitFrame$CommentNumber)
  EmojiSplitGlyphs <- split(SplitFrame$Emoji, SplitFrame$CommentNumber)

  # Rows in DF that contain emoji
  EmojiRows <- as.numeric(names(EmojiSplitNames))

  # Adding to dataframe
  Emoji <- rep(NA, dim(data)[1])
  EmojiDescriptions <- rep(NA, dim(data)[1])
  Emoji[EmojiRows] <- I(EmojiSplitGlyphs)
  EmojiDescriptions[EmojiRows] <- I(EmojiSplitNames)

  # printing progress report
  if (verbose) {cat("Extracted Emoji from comments \U2713 \n")}


  #### URLs

  # Extract URLs from comments
  Links <- rm_url(data$textOriginal, extract = TRUE)
  Links <- I(Links)

  # printing progress report
  if (verbose) {cat("Extracted Links from comments \U2713 \n")}

  #### ASCII smileys

  # Extracting Smiley column
  Smilies <- sapply(strsplit(data$textOriginal, " "), function(x) x[x %in% SmileyVec])
  Smilies[lapply(Smilies, length) == 0] <- NA
  Smilies <- I(Smilies)

  # printing progress report
  if (verbose) {cat("Extracted Smilies from comments \U2713 \n")}

  #### Timestamp mentions
  TimeStamps <- stri_extract_all_regex(data$textOriginal, pattern = "(^|\\s|@)\\d{1,3}:\\d{2}")
  TimeStamps <- trimws(TimeStamps, which = "both")
  TimeStamps <- gsub("@", "", TimeStamps)
  TimeStamps <- I(TimeStamps)

  # printing progress report
  if (verbose) {cat("Extracted Timestamps from comments \U2713 \n")}

  #### User name mentions
  # FIXME: This can't extract mentions where the username includes whitespace
  # For tuber comments, they are distinguishable by @ vs @@ mentions, but not for vosonSML
  UserMentions <- stri_extract_all_regex(data$textOriginal, pattern = "(?<=\\s|^)@{1,2}\\w+")
  UserMentions <- gsub("@@", "@", UserMentions)
  UserMentions <- gsub("@\\d{1,3}$", "", UserMentions, perl = TRUE)
  UserMentions[UserMentions == ""] <- NA
  UserMentions <- I(UserMentions)

  # printing progress report
  if (verbose) {cat("Extracted UserMentions from comments \U2713 \n")}


  #### Creating cleaned up version of comments ####

  # assign cleaned comments to new variable
  comments_cleaned <- data$textOriginal

  # removing links
  comments_cleaned <- rm_url(comments_cleaned, extract = FALSE)

  # removing user mentions
  comments_cleaned <- stri_replace_all_regex(comments_cleaned,"(?<=\\s|^)@{1,2}\\w+","")

  # removing non-words
  comments_cleaned <- rm_non_words(comments_cleaned)

  # printing progress report
  if (verbose) {cat("Created cleaned version of comments \U2713 \n")}


  #### Combine everything into one dataframe
  df <- cbind.data.frame(data$videoId,
                         data$authorDisplayName,
                         data$textOriginal,
                         comments_cleaned,
                         I(Emoji),
                         I(EmojiDescriptions),
                         I(Smilies),
                         as.numeric(data$likeCount),
                         I(Links),
                         I(TimeStamps),
                         I(UserMentions),
                         data$publishedAt,
                         data$updatedAt,
                         data$parentId,
                         data$id,
                         stringsAsFactors = FALSE)

  # setting column names
  names(df) <- c("VideoID",
                 "Author",
                 "OriginalText",
                 "CleanedText",
                 "Emoji",
                 "EmojiDescription",
                 "Smilies",
                 "LikeCount",
                 "URL",
                 "Timestamps",
                 "UserMentions",
                 "Published",
                 "Updated",
                 "ParentId",
                 "CommentID")


  #### Adding Meta-info to df ####
  attributes(df) <- c(attributes(df),
                      list(
                        origin_package = package,
                        tubecleanR_version = as.character(packageVersion("tubecleanR")),
                        comments = dim(df)[1],
                        links = sum(!is.na(df$URL)),
                        emoji = sum(!is.na(df$Emoji)),
                        smilies = sum(!is.na(df$Smilies)),
                        usermentions = sum(!is.na(df$UserMentions)),
                        timestamps = sum(!is.na(df$Timestamps))
                      ))

  # removing rownames
  row.names(df) <- NULL

  # printing progress report
  if (verbose) {cat("Combined final dataframe \U2713 \n")}

  #### return results
  return(df)
}
