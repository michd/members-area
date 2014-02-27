Controller = require '../controller'

module.exports = class StaticController extends Controller
  home: ->
    if @req.user?
      @redirectTo "/dashboard", status: 307
    else
      @redirectTo "/login", status: 307

  404: ->
    @template = '404-loggedin' if @loggedInUser?

  error: ->
    @template = 'error-loggedin' if @loggedInUser?
