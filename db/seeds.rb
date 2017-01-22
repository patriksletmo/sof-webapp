# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Contact.delete_all
#c1 = Contact.create(name: "Daniel Modig", title: "General", email: "general@sof17.se")
#c2 = Contact.create(name: "Victoria Boman", title: "Personal", email: "personal@sof17.se")





Contact.create([
 {name: "Daniel Modig", title: "General", email: "general@sof17.se", group: "main"},
 {name: "Samuel Trennelius", title: "Controller", email: "controller@sof17.se", group: "main"},
 {name: "Gustav Gränsbo", title: "Orkester och Ljud", email: "orkester-ljud@sof17.se", group: "main"},
 {name: "Lukas Lindqvist", title: "IT", email: "it@sof17.se", group: "it"},
 {name: "Elin Östberg", title: "Festvalsamordnare", email: "festival@sof17.se", group: "main"},
 {name: "Matilda Nylund", title: "Event", email: "event@sof17.se", group: "board"},
 {name: "Josefin Ringenson", title: "Riks-SMASK", email: "riks-smask@sof17.se", group: "main"},
 {name: "Maria Andersson", title: "Art director", email: "ad@sof17.se", group: "board"},
 {name: "Victoria Boman", title: "Personal", email: "personal@sof17.se", group: "main"},
 {name: "Simon Rung", title: "Administration", email: "administration@sof17.se", group: "main"},
 {name: "Filip Renström", title: "Kampanj", email: "kampanj@sof17.se", group: "main"},
 {name: "Tobias Sjöberg", title: "Servering", email: "servering@sof17.se", group: "board"},
 {name: "Anton Kullberg", title: "Område", email: "omrade@sof17.se", group: "board"},
 {name: "Filip Gardler", title: "Samarbete och Spons", email: "sponssamarbete@sof17.se", group: "main"},
 {name: "Marcus Eriksson", title: "Säkerhet", email: "sakerhet@sof17.se", group: "board"},
 {name: "Junior Asante", title: "Kårtege", email: "kartege@sof17.se", group: "main"},
 {name: "Irma Hamzic", title: "Marknadsföring", email: "mf@sof17.se", group: "board"}
               ])
