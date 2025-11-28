# tuberComments

An example dataset to showcase the structure of YouTube comments
extracted using the `get_comments` or `get_comments_all` function from
the tuber package.

## Usage

``` r
tuberComments
```

## Format

A data frame with 24 rows and 16 columns:

- channelId:

  ID of the Channel the Video was posted on.

- videoId:

  ID of the Video the comments were posted under

- textDisplay:

  HTML formatted version of the comment text

- textOriginal:

  Comment text as it is displayed to the users, without HTML formatting

- authorDisplayName:

  The display name of the user who posted the comment.

- authorProfileImageUrl:

  The URL for the avatar of the user who posted the comment

- authorChannelUrl:

  URL to the channel of the comment author

- authorChannelId.value:

  he ID of the comment author's YouTube channel, if available

- canRate:

  This setting indicates whether the current viewer can rate the comment

- viewerRating:

  The rating the viewer has given to this comment

- likeCount:

  The total number of likes (positive ratings) the comment has received

- publishedAt:

  Date and time the comment was posted

- updatedAt:

  Date and time the comment was last updated

- id:

  ID of the comment

- parentId:

  ID of the parent comment, if the comment is a reply

- moderationStatus:

  The comment's moderation status. This property is only returned if the
  API request was authorized by the owner of the channel or the video on
  which the requested comments were made

## Source

The data was modeled to resemble a random subset of 24 comments from the
following YouTube video: <https://www.youtube.com/watch?v=1aheRpmurAo>,
exported with the tuber package. It was manually recreated to comply
with YouTube's terms of service while still preserving the general
structure for demonstration purposes.
