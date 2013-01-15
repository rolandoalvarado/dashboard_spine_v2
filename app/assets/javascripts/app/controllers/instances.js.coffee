$ = jQuery.sub()
Instance = App.Instance

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Instance.find(elementID)

class New extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view('instances/new')

  back: ->
    @navigate '/instances'

  submit: (e) ->
    e.preventDefault()
    instance = Instance.fromForm(e.target).save()
    @navigate '/instances', instance.id if instance

class Edit extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
  
  constructor: ->
    super
    @active (params) ->
      @change(params.id)
      
  change: (id) ->
    @item = Instance.find(id)
    @render()
    
  render: ->
    @html @view('instances/edit')(@item)

  back: ->
    @navigate '/instances'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/instances'

class Show extends Spine.Controller
  events:
    'click [bata-type=edit]': 'edit'
    'click [data-type=back]': 'back'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Instance.find(id)
    @render()

  render: ->
    @html @view('instances/show')(@item)

  edit: ->
    @navigate '/instances', @item.id, 'edit'

  back: ->
    @navigate '/instances'

class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    Instance.bind 'refresh change', @render
    Instance.fetch()
    
  render: =>
    instances = Instance.all()
    @html @view('instances/index')(instances: instances)
    
  edit: (e) ->
    item = $(e.target).item()
    @navigate '/instances', item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/instances', item.id
    
  new: ->
    @navigate '/instances/new'
    
class App.Instances extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/instances/new':      'new'
    '/instances/:id/edit': 'edit'
    '/instances/:id':      'show'
    '/instances':          'index'
    
  default: 'index'
  className: 'stack instances'
