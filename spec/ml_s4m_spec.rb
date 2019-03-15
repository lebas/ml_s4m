require "spec_helper"

describe MlS4m do
  it "has a version number" do
    expect(MlS4m::VERSION).not_to be '0.9.5'
  end

  let(:ml) { MlS4m::MercadoLivre.new }
  it "search in INFO" do
    list_search = ml.setPNSearch("MPTU2", "ML_INFO")
    expect(list_search).not_to eq([])
    expect(list_search.uniq).not_to eq([0.0])
  end

  it "search in DRONE" do
    list_search = ml.setPNSearch("AIR", "ML_DRONE")
    expect(list_search).not_to eq([])
    expect(list_search.uniq).not_to eq([0.0])
  end

  it "search in CAMERA" do
    list_search = ml.setPNSearch("HERO", "ML_CAMERA")
    expect(list_search).not_to eq([])
    expect(list_search.uniq).not_to eq([0.0])
  end

  it "search in PHONE" do
    list_search = ml.setPNSearch("A1901", "ML_PHONE")
    expect(list_search).not_to eq([])
    expect(list_search.uniq).not_to eq([0.0])
  end
end
