#' tuberComments
#'
#' An example dataset to showcase the structure of YouTube comments extracted
#' using the \code{\link[get_comments()]{get_comments}} or \code{\link[get_all_comments()]{get_comments_all}}
#'  function from the \pkg{tuber} package.
#'
#' @format A data frame with 24 rows and 16 columns:
#' \describe{
#'   \item{channelId}{ID of the Channel the Video was posted on.}
#'   \item{videoId}{ID of the Video the comments were posted under}
#'   \item{textDisplay}{HTML formatted version of the comment text}
#'   \item{textOriginal}{Comment text as it is displayed to the users, without HTML formatting}
#'   \item{authorDisplayName}{The display name of the user who posted the comment.}
#'   \item{authorProfileImageUrl}{The URL for the avatar of the user who posted the comment}
#'   \item{authorChannelUrl}{URL to the channel of the comment author}
#'   \item{authorChannelId.value}{he ID of the comment author's YouTube channel, if available}
#'   \item{canRate}{This setting indicates whether the current viewer can rate the comment}
#'   \item{viewerRating}{The rating the viewer has given to this comment}
#'   \item{likeCount}{The total number of likes (positive ratings) the comment has received}
#'   \item{publishedAt}{Date and time the comment was posted}
#'   \item{updatedAt}{Date and time the comment was last updated}
#'   \item{id}{ID of the comment}
#'   \item{parentId}{ID of the parent comment, if the comment is a reply}
#'   \item{moderationStatus}{The comment's moderation status. This property is only returned if the API request was authorized by the owner of the channel or the video on which the requested comments were made}
#'
#' }
#' @source The data was modeled to resemble a random subset of 24 comments from the following YouTube video:
#' \url{https://www.youtube.com/watch?v=1aheRpmurAo}, exported with the tuber package. It was manually recreated to comply with
#' YouTube's terms of service while still preserving the general structure for demonstration purposes.
"tuberComments"
