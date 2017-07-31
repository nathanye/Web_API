require 'rails_helper'

RSpec.describe "API_V1::Auth", :type => :request do

  example "register" do
    post "/api/v1/signup", params: { :email => "test2@example.com", :password => "12345678"}

    expect(response).to have_http_status(200)

    # 检查数据库中真的有存进去

    new_user = User.last
    expect(new_user.email).to eq("test2@example.com")

    # 检查回传的 JSON

    expect(response.body).to eq( { :user_id => new_user.id }.to_json )
  end

  example "register failed" do
    post "/api/v1/signup", params: { :email => "test2@example.com" }

    # 测试没有传密码，注册失败的情形

    expect(response).to have_http_status(400)

    expect(response.body).to eq( { :message => "Failed", :errors => {:password => ["can't be blank"]}  }.to_json )
  end
end
