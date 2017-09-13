Admin.create!(:id=>1,:login_id=>'admin',:email => 'toughjjh@gmail.com',:nickname=>'관리자',:password => '123456', :password_confirmation => '123456',:photo=>File.open(Rails.root.join("app","assets", "images", "dog.png")))
Admin.create!(:id=>2,:parent_id=>1,:login_id=>'sub_admin',:nickname=>'서브관리자',:password => '123456', :password_confirmation => '123456',:photo=>File.open(Rails.root.join("app","assets", "images", "dog.png")))
Admin.create!(:id=>3,:parent_id=>1,:login_id=>'operator',:nickname=>'운영자',:password => '123456', :password_confirmation => '123456',:photo=>File.open(Rails.root.join("app","assets", "images", "dog.png")))
Admin.create!(:id=>4,:parent_id=>1,:login_id=>'clinomics',:nickname=>'출력원',:password => 'cxgenosolution', :password_confirmation => 'cxgenosolution',:photo=>File.open(Rails.root.join("app","assets", "images", "dog.png")))
Admin.create!(:id=>5,:parent_id=>1,:login_id=>'reader',:nickname=>'읽기전용',:password => '123456', :password_confirmation => '123456',:photo=>File.open(Rails.root.join("app","assets", "images", "dog.png")))

Role.create!(:id=>1,:title=>'administrator')
Role.create!(:id=>2,:title=>'operator')
Role.create!(:id=>3,:title=>'exporter')
Role.create!(:id=>4,:title=>'reader')

Group.create!(id: 1, title: '웹가입 회원', enable: true)
Group.create!(id: 2, title: '앱가입 회원', enable: true)
Group.create!(id: 3, title: '외부연계 회원', enable: true)

RolesAdmin.create!(:role_id=>1,:admin_id=>1)
RolesAdmin.create!(:role_id=>1,:admin_id=>2)
RolesAdmin.create!(:role_id=>2,:admin_id=>3)
RolesAdmin.create!(:role_id=>2,:admin_id=>4)
RolesAdmin.create!(:role_id=>4,:admin_id=>5)

app = Rpush::Gcm::App.new
app.name = "android_app"
app.auth_key = "AAAAMWgqcXM:APA91bFFjJN5CvxPeKMW_sbxh8h3wZ0PDoJYHZzooaZUcbdfB4cuht3FqFevKVF7dojtcCApm77nFN-Mi59BnbRK7yUo3jqxYoW_ofDw55cOCk9zBym5BCAc7M6LvxMChYDGddNfs7fl"
app.connections = 1
app.save!
