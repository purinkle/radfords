FactoryGirl.define do
  factory :order do
    address_line_1 '1 Test Street'
    address_city 'Testerton'
    address_county 'Testshire'
    address_post_code 'TE5 7TE'
    basket
    email 'alphonso.quigley@example.com'
    name 'Alphonso Quigley'
  end
end
