require "test_helper"

class ExpertTest < ActiveSupport::TestCase
  test "valid expert" do
    expert = Expert.new(
      name: "Test Expert",
      city: "Bratislava",
      email: "test@example.com"
    )
    assert expert.valid?
  end

  test "requires name" do
    expert = Expert.new(city: "Bratislava", email: "test@example.com")
    assert_not expert.valid?
    assert_includes expert.errors[:name], "nemôže byť prázdne"
  end

  test "requires city" do
    expert = Expert.new(name: "Test", email: "test@example.com")
    assert_not expert.valid?
    assert_includes expert.errors[:city], "nemôže byť prázdne"
  end

  test "requires email" do
    expert = Expert.new(name: "Test", city: "Bratislava")
    assert_not expert.valid?
    assert_includes expert.errors[:email], "nemôže byť prázdne"
  end

  test "validates email format" do
    expert = Expert.new(name: "Test", city: "Bratislava", email: "invalid")
    assert_not expert.valid?
    assert_includes expert.errors[:email], "je neplatné"
  end

  test "active scope returns only active experts" do
    active = Expert.create!(name: "Active", city: "City", email: "active@test.com", active: true)
    inactive = Expert.create!(name: "Inactive", city: "City", email: "inactive@test.com", active: false)

    assert_includes Expert.active, active
    assert_not_includes Expert.active, inactive
  end

  test "by_city scope filters by city" do
    bratislava = Expert.create!(name: "BA Expert", city: "Bratislava", email: "ba@test.com")
    kosice = Expert.create!(name: "KE Expert", city: "Kosice", email: "ke@test.com")

    assert_includes Expert.by_city("Bratislava"), bratislava
    assert_not_includes Expert.by_city("Bratislava"), kosice
  end

  test "by_city scope returns all when city is blank" do
    expert = Expert.create!(name: "Expert", city: "Bratislava", email: "test@test.com")

    assert_includes Expert.by_city(nil), expert
    assert_includes Expert.by_city(""), expert
  end
end
