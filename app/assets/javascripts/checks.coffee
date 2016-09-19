# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#hide_passed").on "change", (e) ->
    $(@).closest("form").submit()

  $("#check-button").on "click", (e) ->
    repos = $(".repos tr:not(:first-child) .name").map -> $(@).data("repo")
    checkRepos(repos.get().reverse())

checkRepos = (repos) ->
  return if repos.length is 0
  repo = repos.pop()
  $.ajax({
    method: "POST",
    url: "check",
    data: { repo: repo, check: "isValidJava" }
    dataType: "json"
  })
    .then (res) ->
      status = res.status.charAt(0).toUpperCase() + res.status.substr(1)
      $(".#{repo} .isValidJava").text status
      checkRepos(repos)
