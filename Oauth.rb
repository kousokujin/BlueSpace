require "rubygems"
require "twitter"
require "oauth"
require "gtk2"

class Add_account
  $consumer_key = "q7bJQrX8mBDuyGWHHVvZWQ"
  $consumer_secret = "9MV11AFvzOUeSs4P6sP75BHdkI7t7SHS6iCNRQuapA"
  
  def pin_to_token(pin) #pinコードからtokenを得て、ファイルに出力
    access_token = @request_token.get_access_token(
        oauth_verifier: pin)
      token_data = File.open("token.tkn","w") #token.tknを書き込みで開く
      token_data.puts("#{access_token.token}") #access_token,tokenをtoken.tknに出力
      token_data.puts("#{access_token.secret}") #access_token.secretをtoken.tknに出力
      token_data.close
  end
  
  def get_accsess_window
    #ウィンドウ作成
    @add_account_win = Gtk::Window.new("アカウント追加")
    pin_input_label = Gtk::Label.new("pinコードを入力してください。")
    @pin_entry = Gtk::Entry.new
    @pin_button = Gtk::Button.new("認証")
    main_table = Gtk::Table.new(4,2,true)
    main_table.attach_defaults(pin_input_label,0,3,0,1)
    main_table.attach_defaults(@pin_entry,0,3,1,2)
    main_table.attach_defaults(@pin_button,3,4,1,2)
    
    @add_account_win.add(main_table)
  end
  
  def get_accsess_first
    @pin_button.signal_connect("clicked") do
      pin = @pin_entry.text
      access_token = @request_token.get_access_token(
        oauth_verifier: pin.to_i)
      token_data = File.open("token.tkn","w") #token.tknを書き込みで開く
      token_data.puts("#{access_token.token}") #access_token,tokenをtoken.tknに出力
      token_data.puts("#{access_token.secret}") #access_token.secretをtoken.tknに出力
      token_data.close
      Gtk.main_quit()
   end
  end
  
  def get_accsess
    @add_account_win.show_all()
    consumer = OAuth::Consumer.new($consumer_key,$consumer_secret,{:site => "https://api.twitter.com"})
    @request_token = consumer.get_request_token 
    system "xdg-open #{@request_token.authorize_url}"
  end
end

class Account
  def login
    @accsess_token = "none"
    @accsess_secret = "none"
    open("token.tkn"){|accsess_token_data|
      @accsess_token = accsess_token_data.readlines[0]
      }
    open("token.tkn"){|accsess_secret_data|
      @accsess_secret = accsess_secret_data.readlines[1]
      }
       
    @accsess_token = @accsess_token.chomp
    @accsess_secret = @accsess_secret.chomp
      
    $client = Twitter::REST::Client.new do |config|
      config.consumer_key = $consumer_key
      config.consumer_secret = $consumer_secret
      config.access_token = @accsess_token
      config.access_token_secret = @accsess_secret
    end
   end
end