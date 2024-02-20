#' parsetuber
#'
#' Processed version of tuberComments dataset.
#'
#' @format A data frame with 24 rows and 15 columns:
#' \describe{
#'   \item{VideoID}{ID of the YouTube video the comment was posted under.}
#'   \item{Author}{Username of the commenter.}
#'   \item{OriginalText}{Comment text including user mentions, timestamps, emoji, numbers, ascii-art etc. }
#'   \item{CleanedText}{Preprocessed version of comments, excluding all non-word strings and characters.}
#'   \item{Emoji}{List of emoji extracted from comments}
#'   \item{EmojiDescription}{List of textual descriptions for emoji extracted from comments.}
#'   \item{Emoticons}{List of emoticons extracted from comments.}
#'   \item{LikeCount}{Number of likes the comment received.}
#'   \item{URL}{List of URLs extracted from comments.}
#'   \item{Timestamps}{List of timestamps extracted from comments.}
#'   \item{UserMentions}{List of user mentions extracted from comments.}
#'   \item{Published}{Timestamp of when the comment was posted.}
#'   \item{Updated}{Timestamp of when the comment was last updated.}
#'   \item{ParentId}{ID of the parent comment, if comment is a reply to a previous comment.}
#'   \item{CommentID}{Unique ID of the comment}
#'
#' }
#' @source Result of running parse_yt_comments(tuberComments)
"parsetuber"
