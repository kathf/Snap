require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  render_views
  let(:album) { Album.create!(name: "Landscapes") }

  describe '#new' do
    before  { get :new, album_id: album.id }
    subject { response }

    it { is_expected.to be_success }
    it { is_expected.to render_template('new') }
  end

  describe '#edit' do
    let(:photo) { album.photos.create!(description: "Mountain") }

    before  { get :edit, album_id: album.id, id: photo.id  }
    subject { response }

    it { is_expected.to be_success }
    it { is_expected.to render_template('edit') }
  end

  describe '#create' do
    context 'valid attributes' do
      let(:attrs) { { description: 'Mountain' } }

      specify 'that a photo is created' do
        expect { post :create, photo: attrs, album_id: album.id }.to change { Photo.count }.by(1)
      end

      specify 'that the user is redirected' do
        post :create, photo: attrs, album_id: album.id
        expect(response).to redirect_to(album_photos_url(album))
      end
    end

    context 'invalid attributes' do
      let(:attrs) { { description: '' } }

      specify 'that a photo is not created' do
        expect { post :create, photo: attrs, album_id: album.id }.to_not change { Photo.count }
      end

      specify 'that the user is redirected to the new page' do
        post :create, photo: attrs, album_id: album.id
        expect(response).to render_template('new')
      end
    end
  end

  describe '#destroy' do
    let!(:photo) { Photo.create!(description: "Mountain") }

    specify 'that the photo is deleted' do
      expect{ delete :destroy, album_id: album.id, id: photo.id }.to change { Photo.count }.by(-1)
    end

    #not working
    specify 'that the user is redirected to album index page' do
      delete :destroy, id: photo.id, album_id: album.id
      expect(response).to redirect_to(album_photos_url(album))
    end

    #not working
    specify 'that the flash notice is displayed' do
      delete :destroy, id: photo.id, album_id: album.id
      expect(flash[:notice]).to be_present
    end
  end

  describe '#update' do
    context 'valid attributes' do
      let!(:photo) { album.photos.create!(description: "Mountain") }
      let(:attrs) { { description: "Bird" } }

      # this only works with 'Album.find(album.id).description' evaluated for change (not just 'album.description')
      specify 'that the photo description is updated' do
        expect { put :update, album_id: album.id, id: photo.id, photo: attrs }.to change{ Photo.find(photo.id).description }.from("Mountain").to("Bird")
      end

      specify 'that the user is redirected to photo show page' do
        put :update, album_id: album.id, id: photo.id, photo: attrs
        expect(response).to redirect_to(album_photo_url(album,photo))
      end

      specify 'that the flash notice is displayed' do
        put :update, album_id: album.id, id: photo.id, photo: attrs
        expect(flash[:notice]).to be_present
      end
    end

    context 'invalid attributes' do
      let!(:photo) { album.photos.create!(description: "Mountain") }
      let(:attrs) { { description: '' } }

      #not working
      specify 'that the photo description is not updated' do
        expect { patch :update, album_id: album.id, id: photo.id, photo: attrs }.to_not change{ Photo.find(photo.id).description }
      end

      #not working
      specify 'that the user is redirected to edit page' do
        put :update, album_id: album.id, id: photo.id, photo: attrs
        expect(response).to render_template('edit')
      end

    end
  end
end
