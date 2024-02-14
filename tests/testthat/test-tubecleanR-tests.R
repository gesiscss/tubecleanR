#################### TESTING ESSENTIAL FUNCTION #####################
library(tubecleanR)

#### Testing for tuber

test_that("Testing parse_yt_comments() for tuber",{

  # loading test data and checking data
  tuber_comments <- readRDS(system.file("tuberComments.rds", package = "tubecleanR"))
  tuber_gold <- readRDS(system.file("parsetuber.rds", package = "tubecleanR"))

  # parsing
  parsed_comments <- parse_yt_comments(tuber_comments)

  # testing for valid dataframe
  expect_equal(class(parsed_comments), "data.frame")

  # testing for identicality
  expect_identical(parsed_comments,tuber_gold)

})

#### Testing for VosonSML

test_that("Testing parse_yt_comments() for vosonSML",{

  # loading test data and checking data
  voson_comments <- readRDS(system.file("VosonComments.rds", package = "tubecleanR"))
  voson_gold <- readRDS(system.file("parsevoson.rds", package = "tubecleanR"))

  # parsing
  parsed_comments <- parse_yt_comments(voson_comments)

  # testing for valid dataframe
  expect_equal(class(parsed_comments), "data.frame")

  # testing for identicality
  expect_identical(parsed_comments,voson_gold)

})
