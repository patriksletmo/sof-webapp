# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Contact.delete_all
Contact.create([{name: "Daniel Modig", title: "General", email: "general@sof17.se"},
                {name: "Victoria Boman", title: "Personal", email: "personal@sof17.se"},
                {name: "Lukas Lindqvist", title: "IT", email: "it@sof17.se"},
                {name: "Gustav Gränsbo", title: "Orkester och Ljud", email: "orkester-ljud@sof17.se"},
                {name: "Josefin Ringenson", title: "Riks-SMASK", email: "riks-smask@sof17.se"},
                {name: "Simon Rung", title: "Administration", email: "administration@sof17.se"},
                {name: "Junior Asante", title: "Kårtege", email: "kartege@sof17.se"}])
