FactoryGirl.define do
  sequence :support_agent_email do |n|
    "agent#{n}@example.com"
  end

  sequence :customer_email do |n|
    "customer#{n}@example.com"
  end

  sequence :admin_email do |n|
    "admin#{n}@example.com"
  end
end
