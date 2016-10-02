module AresMUSH
  module Install
    def self.init_db

      Ohm.redis.call "FLUSHDB"
      
      game = Game.create

      puts "Creating start rooms."
  
      welcome_room = Room.create(
        :name => "Welcome Room", 
        :room_type => "OOC", 
        :area => "Offstage",
        :repose_on => false, 
        :description => "Welcome!%R%R" + 
            "New to MUSHing?  Visit http://aresmush.com/mush-101/ for an interactive tutorial.%R%R" +
            "New to Ares?  http://aresmush.com/ares-for-vets for a quick intro geared towards veteran players")
            
      ic_start_room = Room.create(
        :name => "Onstage", 
        :room_type => "IC",
        :area => "Onstage",
        :repose_on => true, 
        :description => "This is the room where all characters start out."
      )
      
      ooc_room = Room.create(
        :name => "Offstage", 
        :room_type => "OOC", 
        :area => "Offstage",
        :repose_on => false, 
        :description => "This is a backstage area where you can hang out when not RPing.")

      quiet_room = Room.create(
        :name => "Quiet Room", 
        :room_type => "OOC", 
        :area => "Offstage",
        :repose_on => false, 
        :description => "This is a quiet retreat, usually for those who are AFK and don't want to be spammed by conversations while they're away. If you want to chit-chat, please take it outside.")
        
      rp_room_hub = Room.create(
        :name => "RP Annex", 
        :room_type => "OOC", 
        :area => "Offstage",
        :repose_on => false, 
        :is_foyer => true,
        :description => "RP Rooms can be used for backscenes, private scenes, or scenes taking place in areas of the grid that are not coded.")

      6.times do |n|
        rp_room = Room.create(
          :name => "RP Room #{n+1}", 
          :room_type => "IC", 
          :area => "Offstage",
          :repose_on => true, 
          :description => "The walls of the room shimmer. They are shapeless, malleable, waiting to be given form. With a little imagination, the room can become anything.")
        Exit.create(:name => "#{n+1}", :source => rp_room_hub, :dest => rp_room)
        Exit.create(:name => "O", :source => rp_room, :dest => rp_room_hub)
      end

      Exit.create(:name => "RP", :source => ooc_room, :dest => rp_room_hub)
      Exit.create(:name => "QR", :source => ooc_room, :dest => quiet_room)

      Exit.create(:name => "O", :source => welcome_room, :dest => ooc_room)
      Exit.create(:name => "O", :source => quiet_room, :dest => ooc_room)
      Exit.create(:name => "O", :source => rp_room_hub, :dest => ooc_room)
      
      game.welcome_room = welcome_room
      game.ic_start_room = ic_start_room
      game.ooc_room = ooc_room
      game.save
  
      admin_role = Role.create(name: "admin", is_restricted: true)
      admin_role.save
      everyone_role = Role.create(name: "everyone")
      everyone_role.save
      builder_role = Role.create(name: "builder")
      builder_role.save
      guest_role = Role.create(name: "guest")
      guest_role.save
      
      puts "Creating OOC chars."
      
      headwiz = Character.create(name: "Headwiz")
      headwiz.change_password("change_me!")
      headwiz.roles.add admin_role
      headwiz.roles.add everyone_role
      headwiz.room = welcome_room
      headwiz.save
  
      builder = Character.create(name: "Builder")
      builder.change_password("change_me!")
      builder.roles.add builder_role
      builder.roles.add everyone_role
      builder.room = welcome_room
      builder.save
  
      systemchar = Character.create(name: "System")
      systemchar.change_password("change_me!")
      systemchar.roles.add admin_role
      systemchar.roles.add everyone_role
      systemchar.room = welcome_room
      systemchar.save

      4.times do |n|
        guest = Character.create(name: "Guest-#{n+1}")
        guest.roles.add guest_role
        guest.roles.add everyone_role
        guest.room = welcome_room
        guest.save
      end

      game.master_admin = headwiz
      game.system_character = systemchar
      game.save
        
      puts "Creating channels and BBS."
  
      BbsBoard.create(name: "Announcements", order: 1)
      board = BbsBoard.create(name: "Admin", order: 2)
      board.read_roles.add admin_role
      board.write_roles.add admin_role
      board.save
      
      BbsBoard.create(name: "Cookie Awards", order: 3)
      BbsBoard.create(name: "New Arrivals", order: 4)
  
      AresMUSH::Channel.create(name: "Chat", announce: false, description: "Public chit-chat.", color: "%xy", default_alias: [ 'c', 'ch', 'cha' ])
      AresMUSH::Channel.create(name: "Questions", description: "Questions and answers.", color: "%xg", default_alias: [ 'q', 'qu', 'que' ])
      AresMUSH::Channel.create(name: "Admin", description: "Admin business.", roles: ["admin"], color: "%xr", default_alias: [ 'a', 'ad', 'adm' ])
  
  
      puts "Install complete."
    end
  end
end