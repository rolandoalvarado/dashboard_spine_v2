class App.Project extends Spine.Model
  @configure 'Project', 'name', 'description'
  @extend Spine.Model.Ajax
  
  validate: ->
    'name required' unless @name
