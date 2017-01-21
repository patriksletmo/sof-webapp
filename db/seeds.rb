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
 {name: "Daniel Modig", title: "General", email: "general@sof17.se", group: "huvudansvarig"},
 {name: "Samuel Trennelius", title: "Controller", email: "controller@sof17.se", group: "huvudansvarig"},
 {name: "Gustav Gränsbo", title: "Orkester och Ljud", email: "orkester-ljud@sof17.se", group: "huvudansvarig"},
 {name: "Lukas Lindqvist", title: "IT", email: "it@sof17.se", group: "IT"},
 {name: "Elin Östberg", title: "Festvalsamordnare", email: "festival@sof17.se", group: "huvudansvarig"},
 {name: "Matilda Nylund", title: "Event", email: "event@sof17.se", group: "syrelse"},
 {name: "Josefin Ringenson", title: "Riks-SMASK", email: "riks-smask@sof17.se", group: "huvudansvarig"},
 {name: "Maria Andersson", title: "Art director", email: "ad@sof17.se", group: "styrelse"},
 {name: "Victoria Boman", title: "Personal", email: "personal@sof17.se", group: "huvudansvarig"},
 {name: "Simon Rung", title: "Administration", email: "administration@sof17.se", group: "huvudansvarig"},
 {name: "Filip Renström", title: "Kampanj", email: "kampanj@sof17.se", group: "huvudansvarig"},
 {name: "Tobias Sjöberg", title: "Servering", email: "servering@sof17.se", group: "styrelse"},
 {name: "Anton Kullberg", title: "Område", email: "omrade@sof17.se", group: "styrelse"},
 {name: "Filip Gardler", title: "Samarbete och Spons", email: "sponssamarbete@sof17.se", group: "huvudansvarig"},
 {name: "Marcus Eriksson", title: "Säkerhet", email: "sakerhet@sof17.se", group: "styrelse"},
 {name: "Junior Asante", title: "Kårtege", email: "kartege@sof17.se", group: "huvudansvarig"},
 {name: "Irma Hamzic", title: "Marknadsföring", email: "mf@sof17.se", group: "styrelse"}
               ])


Page.delete_all
Page.create(category: "index", page: "", header: "Index view", content: "this is Index view", image: "", show_in_menu: false)
Page.create(category: "pages", page: "test", header: "Test view", content: "<h> rubrik </h> this is test content <img>", image: "https://s3-eu-west-1.amazonaws.com/lintek-sof/sof-homepage/logos/Logga_SOF_pafarg2.png",  show_in_menu: false )
Page.create(category: "contacts", page: "volonteer", header: "Detta är headern",
            content: "<h> Hej :) </h> ASDASDsadadmlsadwrpglö",
            image: "asd",
            show_in_menu: false)

