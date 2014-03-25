require "gtk2"
require "twitter"

class Gui
  def post
    post_hbox = Gtk::HBox.new(false,3)
    post_entry = Gtk::Entry.new()
    post_button = Gtk::Button.new("投稿")
    post_hbox.pack_start(post_entry)
    post_hbox.pack_start(post_button)
    
    post_button.signal_connect("clicked") do
      @post_text = post_entry.text
      $client.update(@post_text)
      post_entry.set_text("")
    end
    
    return post_hbox
  end
end