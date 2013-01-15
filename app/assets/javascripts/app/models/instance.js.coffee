class App.Instance extends Spine.Model
  @configure 'Instance', 'name', 'size', 'qty', 'keypair', 'security_group', 'password'
  @extend Spine.Model.Ajax