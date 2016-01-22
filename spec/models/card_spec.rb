require 'rails_helper'

RSpec.describe Card, type: :model do
  class TestClass
    include Card
  end

  let(:model)        { double }
  let(:current_user) { create :user }

  before do
    @class = TestClass.new(model, current_user)
  end

  describe '#initialize' do
    it 'initializes variables' do
      expect(@class.instance_variable_get(:@model)).to eq(model)
      expect(@class.instance_variable_get(:@current_user)).to eq(current_user)
      expect(@class.instance_variable_get(:@informations)).to eq([])
      expect(@class.instance_variable_get(:@statistics)).to eq([])
    end
  end

  describe '#type' do
    it 'returns card class type' do
      expect(@class.type).to eq('double')
    end
  end

  describe '#path' do
    it 'returns card path' do
      expect(@class.path).to be_nil
    end
  end

  describe '#avatar' do
    let(:attachment_url) { '/xxx' }
    let(:helpers)        { double(attachment_url: attachment_url) }

    before { allow(@class).to receive(:helpers) { helpers } }

    subject { @class.avatar }

    it 'returns avatar url' do
      expect(helpers).to receive(:attachment_url).with(model, :image, :fill, 300, 300, format: 'png')
      subject
    end
  end

  describe '#title' do
    it 'returns card title' do
      expect(@class.title).to be_nil
    end
  end

  describe '#subtitle' do
    it 'returns card subtitle' do
      expect(@class.subtitle).to be_nil
    end
  end

  describe '#informations' do
    let(:informations) { [] }
    let(:image_url)    { '/xxx' }
    let(:helpers)      { double(image_url: image_url) }

    before do
      @class.instance_variable_set(:@informations, informations)
      allow(@class).to receive(:helpers) { helpers }
    end

    subject { @class.informations }

    context 'when not have informations' do
      it 'returns empty array' do
        expect(subject).to eq([])
      end
    end

    context 'when have informations' do
      let(:informations) do
        [
          { title: 'project', icn: '/xxx/xxx.png', link: '/xxxx' }
        ]
      end

      it 'returns informations array with assets sprockets converted path' do
        expect(helpers).to receive(:image_url).with(informations.first[:icn])
        expect(subject).to eq([{ title: 'project', icn: '/xxx', link: '/xxxx' }])
      end
    end
  end

  describe '#statistics' do
    let(:statistics) { [] }
    let(:image_url)  { '/xxx' }
    let(:helpers)    { double(image_url: image_url) }

    before do
      @class.instance_variable_set(:@statistics, statistics)
      allow(@class).to receive(:helpers) { helpers }
    end

    subject { @class.statistics }

    context 'when not have statistics' do
      it 'returns empty array' do
        expect(subject).to eq([])
      end
    end

    context 'when have informations' do
      let(:statistics) do
        [
          { title: 'project', icn: '/xxx/xxx.png', link: '/xxxx' }
        ]
      end

      it 'returns informations array with assets sprockets converted path' do
        expect(helpers).to receive(:image_url).with(statistics.first[:icn])
        expect(subject).to eq([{ title: 'project', icn: '/xxx', link: '/xxxx' }])
      end
    end
  end

  describe '#links' do
    before { allow(@class).to receive(:model_path) { '/xxxx' } }

    it 'receives self and card link' do
      expect(@class.links).to include(:self)
      expect(@class.links).to include(:card)
    end
  end

  describe '#read_attribute_for_serialization' do
    it 'receives send method to model' do
      expect(@class).to receive(:send).with(:title)
      @class.read_attribute_for_serialization(:title)
    end
  end

  describe '#helpers' do
    it 'receives application helpers' do
      expect(ApplicationController).to receive(:helpers)
      @class.helpers
    end
  end

  describe '#likeable' do
    subject { @class.send(:likable) }

    context 'when is not a likeable' do
      it 'receives empty statistics' do
        subject
        expect(@class.instance_variable_get(:@statistics)). to eq([])
      end
    end

    context 'when is likeable' do
      let(:already_liked) { false }

      before do
        allow(@class).to receive(:model_path)         { '/xxx' }
        allow(model.class).to receive(:name)          { 'person' }
        allow(model).to receive(:likers)              { double(count: 10) }
        allow(current_user).to receive(:liked_people) { double(include?: already_liked) }
      end

      context 'when current_user already liked' do
        let(:already_liked) { true }

        it 'receives like statistics selected' do
          subject
          expect(@class.instance_variable_get(:@statistics)).to eq([{ icn: 'icons/cards/icn-likers-selected.svg', link: '/xxx/unlike.json', title: 10 }])
        end
      end

      context 'when current_user not liked' do
        it 'receives like statistics unselected' do
          subject
          expect(@class.instance_variable_get(:@statistics)).to eq([{ icn: 'icons/cards/icn-likers.svg', link: '/xxx/like.json', title: 10 }])
        end
      end
    end
  end

  describe '#followable' do
    subject { @class.send(:followable) }

    context 'when is not a followable' do
      it 'receives empty statistics' do
        subject
        expect(@class.instance_variable_get(:@statistics)). to eq([])
      end
    end

    context 'when is followable' do
      let(:already_followed) { false }

      before do
        allow(@class).to receive(:model_path)            { '/xxx' }
        allow(model.class).to receive(:name)             { 'person' }
        allow(model).to receive(:followers)              { double(count: 10) }
        allow(current_user).to receive(:followed_people) { double(include?: already_followed) }
      end

      context 'when current_user already followed' do
        let(:already_followed) { true }

        it 'receives follow statistics selected' do
          subject
          expect(@class.instance_variable_get(:@statistics)).to eq([{ icn: 'icons/cards/icn-followers-selected.svg', link: '/xxx/unfollow.json', title: 10 }])
        end
      end

      context 'when current_user not followed' do
        it 'receives follow statistics unselected' do
          subject
          expect(@class.instance_variable_get(:@statistics)).to eq([{ icn: 'icons/cards/icn-followers.svg', link: '/xxx/follow.json', title: 10 }])
        end
      end
    end
  end

  describe '#model_path' do
    subject { @class.send(:model_path) }

    before do
      allow(model.class).to receive(:name) { 'person' }
      allow(model).to receive(:id)         { '12345' }
    end

    it 'receives path' do
      expect(subject).to eq('/people/12345')
    end
  end
end
