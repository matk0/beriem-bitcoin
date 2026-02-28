# Create admin user
Admin.find_or_create_by!(email: "admin@beriembitcoin.sk") do |admin|
  admin.password = "changeme123"
  admin.password_confirmation = "changeme123"
end
puts "Admin user created: admin@beriembitcoin.sk / changeme123"

# Create sample experts
experts = [
  {
    name: "Peter Novak",
    city: "Bratislava",
    email: "peter@example.com",
    bio: "Bitcoin entuziasta od roku 2015. Pomohol uz desiatkam podnikov nastavit Bitcoin platby. Specializujem sa na Lightning Network a BTCPay Server.",
    active: true
  },
  {
    name: "Jana Kovacova",
    city: "Kosice",
    email: "jana@example.com",
    bio: "IT konzultantka so zameranim na kryptomeny. Poskytujem skolenia a konzultacie pre male a stredne podniky.",
    active: true
  },
  {
    name: "Martin Horvath",
    city: "Zilina",
    email: "martin@example.com",
    bio: "Vyvojar a Bitcoin maximalist. Pomozen vam s technickym nastavenim a integraciou Bitcoin platieb do vasho e-shopu.",
    active: true
  },
  {
    name: "Eva Tomasova",
    city: "Bratislava",
    email: "eva@example.com",
    bio: "Financna poradkyna so specializaciou na kryptomeny. Pomozen s danovou a pravnou strankou prijimania Bitcoin platieb.",
    active: true
  },
  {
    name: "Lukas Benes",
    city: "Banska Bystrica",
    email: "lukas@example.com",
    bio: "Lightning Network specialista. Prevadzkujem vlastny Lightning node a pomozen s rychlymi a lacnymi platbami.",
    active: true
  }
]

experts.each do |expert_data|
  Expert.find_or_create_by!(email: expert_data[:email]) do |expert|
    expert.name = expert_data[:name]
    expert.city = expert_data[:city]
    expert.bio = expert_data[:bio]
    expert.active = expert_data[:active]
  end
end

puts "Created #{Expert.count} experts"
