# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create! email: 'admin@task.com', password: 'secret', role: 'admin'
list = List.create! created_by: admin.id, title: 'List 1'
Card.create! created_by: admin.id, title: 'List 1', list: list
root = Comment.create! content: 'root', card_id: Card.last.id
a = Comment.create! content: 'a', card_id: Card.last.id, parent_id: root.id
b = Comment.create! content: 'b', card_id: Card.last.id, parent_id: a.id
Comment.create! content: 'c', card_id: Card.last.id, parent_id: b.id
