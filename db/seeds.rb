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


Page.delete_all
Page.create(category: "index", page: "", header: "Index", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas id quam nec enim tristique pharetra. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In odio augue, suscipit in leo id, elementum tristique lacus. Integer sollicitudin dui enim, non mollis erat condimentum nec. Duis consequat justo id elit convallis, a ullamcorper risus rhoncus. Donec tristique, augue sed lacinia scelerisque, nisl orci accumsan felis, at mattis nisi est eu justo. Quisque quis pellentesque purus. Vivamus porta nisi ac dui bibendum interdum. Integer quis mi in nulla tristique luctus. Quisque mattis arcu id orci scelerisque sollicitudin.", image: "", show_in_menu: false)

Page.create(category: "test", page: "", header: "Lorem Ipsum", content: " <img> <h> Neque porro quisquam </h> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse tempus scelerisque dapibus. Ut consequat id erat nec tempor. Vivamus sit amet urna nec risus dignissim fringilla eget sit amet turpis. Cras pharetra sapien in nisi tincidunt, sed vulputate leo euismod. Quisque eu auctor mauris. Morbi venenatis sagittis consectetur. Proin euismod nisi ac consequat aliquam. Nunc tempor eros neque, ac placerat dolor pulvinar in. Suspendisse posuere sapien id nibh vehicula, a posuere ipsum fermentum. Mauris ornare mattis leo id cursus.

Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam erat volutpat. Donec non vehicula tellus. Vestibulum imperdiet tempor nunc, nec volutpat diam scelerisque vel. Sed elementum ligula ut eleifend commodo. Pellentesque vitae condimentum erat. Nullam auctor augue ut imperdiet varius. Sed a volutpat ipsum.

Vestibulum finibus turpis sed condimentum commodo. Curabitur sed sodales orci, id luctus erat. Quisque libero ipsum, consequat sit amet magna vestibulum, vestibulum pharetra odio. In luctus turpis ac augue rutrum blandit. Aenean a luctus elit. Fusce semper dictum sagittis. Mauris leo mi, vestibulum a dignissim sodales, lacinia et ipsum. Praesent pellentesque tempor ex, eget sagittis nisi tempor sed. Nunc dignissim nec quam at volutpat.", image: "https://s3-eu-west-1.amazonaws.com/lintek-sof/sof-homepage/logos/Logga_SOF_pafarg2.png",  show_in_menu: false )

Page.create(category: "foo", page: "bar", header: "Foo Bar", content: " <img> <h> Test </h>  Foo Bar.", image: "https://s3-eu-west-1.amazonaws.com/lintek-sof/sof-homepage/logos/Logga_SOF_pafarg2.png",  show_in_menu: false )
