# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Contact.delete_all
ContactGroup.delete_all

#c1 = Contact.create(name: "Daniel Modig", title: "General", email: "general@sof17.se")
#c2 = Contact.create(name: "Victoria Boman", title: "Personal", email: "personal@sof17.se")
ContactGroup.create([
    {group: "press", title: "Press & Företag"},
    {group: "funkis", title: "Funkis"},
    {group: "orchestra", title: "Orkestrar"},
    {group: "cortege", title: "Kårtege"},
    {group: "tickets", title: "Biljetter"},
    {group: "it", title: "IT/Webbsupport"}
                    ])

Contact.create([
 {name: "Irma Hamzic", title: "Marknadsföringssamordnare", email: "marknadsforing@sof17.se", group: "press"},
 {name: "Filip Gardler", title: "Samarbetsansvarig", email: "samarbete@sof17.se", group: "press"},

 {name: "Emma Carlsson", title: "Funkisputte", email: "funkis@sof17.se", group: "funkis"},
 {name: "Victoria Boman", title: "Personal", email: "personal@sof17.se", group: "funkis"},

 {name: "Gustav Gränsbo", title: "Orkester och Ljud", email: "orkester@sof17.se", group: "orchestra"},
 {name: "Vera Antonov", title: "Mottagningsputte", email: "mottagning@sof17.se", group: "orchestra"},
 {name: "Josefin Ringenson", title: "Riks-SMASK", email: "riks-smask@sof17.se", group: "orchestra"},

 {name: "Junior Asante", title: "Kårtegeansvarig", email: "kartege@sof17.se", group: "cortege"},

 {name: "Joel Strömblad", title: "Biljettputte", email: "biljett@sof17.se", group: "tickets"},

 {name: "Lukas Lindqvist", title: "IT-ansvarig", email: "it@sof17.se", group: "it"}
])
