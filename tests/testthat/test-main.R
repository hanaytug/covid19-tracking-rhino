box::use(
  shiny[testServer],
  testthat[...],
)
box::use(
  app/main[...],
)

# Work In Progress
test_that("main server works", {
  testServer(server, {
    expect_equal("Hello!", "Hello!")
  })
})
