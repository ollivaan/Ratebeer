require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple places are returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("Tampere").and_return(
        [ Place.new( name:"Pyynikin käsityöläispanimo", id: 1 ), Place.new( name:"Panimoravintola Plevna", id: 2 ), Place.new(name:"O'Connell's Irish Bar", id:3) ]
    )
    visit places_path
    fill_in('city', with: 'Tampere')
    click_button "Search"

    expect(page).to have_content "Pyynikin käsityöläispanimo"
    expect(page).to have_content "Panimoravintola Plevna"
    expect(page).to have_content "O'Connell's Irish Bar"
  end
  it "if there is no places" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        []
    )
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end


# 13307	O'Connell's Irish Bar	Beer Bar	Rautatienkatu 24	Tampere	33100	Finland	0
# 18845	Pyynikin käsityöläispanimo	Brewery	Tesoman valtatie 24	Tampere	33300	Finland	0
# 18857	Panimoravintola Plevna	Brewpub	Itäinenkatu 8	Tampere	33210	Finland	0
# Laajenna testiä kattamaan seuraavat tapaukset:

# jos API palauttaa useita olutpaikkoja, kaikki näistä näytetään sivulla

# jos API ei löydä paikkakunnalta yhtään olutpaikkaa (eli paluuarvo on tyhjä taulukko),
# sivulla näytetään ilmoitus "No locations in etsitty paikka"