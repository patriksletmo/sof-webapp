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
 {name: "Daniel Modig", title: "General", email: "general@sof17.se", group: "high"},
 {name: "Samuel Trennelius", title: "Controller", email: "TODO", group: "low"},
 {name: "Gustav Gränsbo", title: "Orkester och Ljud", email: "orkester-ljud@sof17.se", group: "low"},
 {name: "Lukas Lindqvist", title: "IT", email: "it@sof17.se", group: "low"},
 {name: "Elin Östberg", title: "Festvalsamordnare", email: "TODO", group: "low"},
 {name: "Matilda Nylund", title: "Event", email: "event@sof17.se", group: "low"},
 {name: "Josefin Ringenson", title: "Riks-SMASK", email: "riks-smask@sof17.se", group: "low"},
 {name: "Maria Andersson", title: "AD", email: "ad@sof17.se", group: "low"},
 {name: "Victoria Boman", title: "Personal", email: "personal@sof17.se", group: "high"},
 {name: "Simon Rung", title: "Administration", email: "administration@sof17.se", group: "low"},
 {name: "Filip Renström", title: "Kampanj", email: "kampanj@sof17.se", group: "low"},
 {name: "Tobias Sjöberg", title: "servering", email: "servering@sof17.se", group: "low"},
 {name: "Anton Kullberg", title: "Område", email: "omrade@sof17.se", group: "low"},
 {name: "Filip Gardler", title: "SoS", email: "sos@sof17.se", group: "low"},
 {name: "Marcus Eriksson", title: "Säkerhet", email: "sakerhet@sof17.se", group: "low"},
 {name: "Junior Asante", title: "Kårtege", email: "kartege@sof17.se", group: "low"},
 {name: "Irma Hamzic", title: "MF", email: "mf@sof17.se", group: "low"}
               ])





