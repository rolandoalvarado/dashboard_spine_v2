$ = jQuery.sub()
Project = App.Project

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Project.find(elementID)

class New extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view('projects/new')

  back: ->
    @navigate '/projects'

  submit: (e) ->
    e.preventDefault()
    project = Project.fromForm(e.target).save()
    @navigate '/projects', project.id if project

class Edit extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
  
  constructor: ->
    super
    @active (params) ->
      @change(params.id)
      
  change: (id) ->
    @item = Project.find(id)
    @render()
    
  render: ->
    @html @view('projects/edit')(@item)

  back: ->
    @navigate '/projects'

  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
  
  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/projects'

class Show extends Spine.Controller
  events:
    'click [data-type=edit]': 'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=back]': 'back'
    'click [data-type=new]': 'New'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Project.find(id)
    @render()

  render: ->
    @html @view('projects/show')(@item)

  edit: ->
    @navigate '/projects', @item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')

  back: ->
    @navigate '/projects'

class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'
    'click [data-type=new_instance]':     'new_instance'
    

  constructor: ->
    super
    Project.bind 'refresh change', @render
    Project.fetch()
    
  render: =>
    projects = Project.all()
    @html @view('projects/index')(projects: projects)
    
  edit: (e) ->
    item = $(e.target).item()
    @navigate '/projects', item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/projects', item.id
  
  new: ->
    @navigate '/projects/new'
  
  new_instance: ->
    @navigate '/projects/new_instance'  
 


class App.Projects extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/projects/new':      'new'
    '/projects/:id/edit': 'edit'
    '/projects/:id':      'show'
    '/projects':          'index'
    
  default: 'index'
  className: 'stack projects'
