require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  render_views

  describe '#index' do
    specify 'that the index page loads successfully' do
      get :index
      expect(response).to be_success
      expect(response).to render_template('index')
    end
  end

  describe '#show' do
    let(:album) { Album.create!(name: "Landscapes") }
    specify 'that the show page loads successfully' do
      get :show, id: album.id
      expect(response).to redirect_to(album_photos_path(album))
    end
  end

  describe '#new' do
    specify 'that the new page loads successfully' do
      get :new
      expect(response).to be_success
      expect(response).to render_template('new')
    end
  end

  describe '#edit' do
    let(:album) { Album.create!(name: "Landscapes") }

    before  { get :edit, id: album.id }
    subject { response }

    it { is_expected.to be_success }
    it { is_expected.to render_template('edit') }
  end

  describe '#create' do
    context 'valid attributes' do
      let(:attrs) { { name: 'Landscape' } }

      specify 'that an album is created' do
        expect { post :create, album: attrs }.to change { Album.count }.by(1)
      end

      specify 'that the user is redirected' do
        post :create, album: attrs
        expect(response).to redirect_to(album_url(Album.last))
      end
    end

    context 'invalid attributes' do
      let(:attrs) { { name: '' } }

      specify 'that an album is not created' do
        expect { post :create, album: attrs }.to_not change { Album.count }
      end

      specify 'that the user is redirected to the new page' do
        post :create, album: attrs
        expect(response).to render_template('new')
      end
    end
  end

  describe '#destroy' do
    let!(:album) { Album.create!(name: "Landscapes") }

    specify 'that the album is deleted' do
      expect{ delete :destroy, id: album.id }.to change { Album.count }.by(-1)
    end

    specify 'that the user is redirected to albums index' do
      delete :destroy, id: album.id
      expect(response).to redirect_to(albums_url)
    end

    specify 'that the flash notice is displayed' do
      delete :destroy, id: album.id
      expect(flash[:notice]).to be_present
    end
  end

  describe '#update' do
    context 'valid attributes' do
      let!(:album) { Album.create!(name: "Landscapes") }
      let(:attrs) { { name: "Birds" } }

      # this only works with 'Album.find(album.id).name' evaluated for change (not just 'album.name')
      specify 'that the album name is updated' do
        expect { put :update, id: album.id, album: attrs }.to change{ Album.find(album.id).name }.from("Landscapes").to("Birds")
      end

      specify 'that the user is redirected to album show page' do
        put :update, id: album.id, album: attrs
        expect(response).to redirect_to(album_url(album))
      end

      specify 'that the flash notice is displayed' do
        put :update, id: album.id, album: attrs
        expect(flash[:notice]).to be_present
      end
    end

    context 'invalid attributes' do
      let!(:album) { Album.create!(name: "Landscapes") }
      let(:attrs) { { name: '' } }

      specify 'that the album name is not updated' do
        expect { patch :update, id: album.id, album: attrs }.to_not change{ Album.find(album.id).name }
      end

      specify 'that the user is redirected to edit page' do
        put :update, id: album.id, album: attrs
        expect(response).to render_template('edit')
      end

    end
  end

end
