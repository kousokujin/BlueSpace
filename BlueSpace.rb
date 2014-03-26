require "gtk2"
require "./Oauth.rb"
require "./Window.rb"

add_act = Add_account.new()
add_act.get_accsess_window()
unless File.exists?("token.tkn") then
  add_act.get_accsess_window()
  add_act.get_accsess_first()
  add_act.get_accsess()
  Gtk.main()
end

act = Account.new()
act.login()
gui_parts = Gui.new
main_win = Gtk::Window.new("BlueSpace")
main_tab = Gtk::Table.new(4,2,true)
post = gui_parts.post()
main_tab.attach_defaults(post,0,4,0,1)

main_win.signal_connect("destroy")do
   Gtk.main_quit()
end

main_win.add(main_tab)
main_win.show_all()
Gtk.main()