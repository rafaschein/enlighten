require 'rails_helper'

RSpec.describe ApplicationPolicy, type: :policy do
  let(:user)   { double }
  let(:record) { double }

  subject { described_class.new(user, record) }

  describe '.initialize' do
    it 'receive current user' do
      expect(subject.instance_variable_get(:@user)).to eq(user)
    end

    it 'receive record' do
      expect(subject.instance_variable_get(:@record)).to eq(record)
    end
  end

  describe '.scope' do
    it 'receive policy inside scope' do
      expect(Pundit).to receive(:policy_scope!).with(user, record.class)
      subject.scope
    end
  end

  describe '.method_missing' do
    context 'check if current user has permission for method by method missing' do
      it 'receive permission?' do
        expect(subject).to receive(:permission?).with(:create?)
        subject.create?
      end
    end
  end

  describe '.model_symbol' do
    context 'returns model symbol by instance class or symbol' do
      context 'when Symbol is record' do
        let(:record) { :time }

        it 'receives symbol' do
          expect(subject.send(:model_symbol)).to eq(:time)
        end
      end

      context 'when Class is record' do
        let(:record) { Time.new }

        it 'receives symbol' do
          expect(subject.send(:model_symbol)).to eq(:time)
        end
      end
    end
  end

  describe '.model_name' do
    context 'transform model symbol to name' do
      let(:record) { Time.new }

      it 'receives model name with string' do
        expect(subject.send(:model_name)).to eq('time')
      end
    end
  end

  describe '.action_name' do
    context 'parse action name with pundit pattern ? and remove to find permission' do
      it 'receives action name without ?' do
        expect(subject.send(:action_name, :create?)).to eq('create')
      end
    end
  end

  describe '.has_permission?' do
    context 'when user not have roles' do
      it 'receive permission roles' do
        expect(user).to receive(:permission_roles) { [] }
        expect(subject.send(:permission?, :create?)).to be false
      end
    end

    context 'when user have roles' do
      let(:permission_roles) { [double(permission_acls: permission_acls)] }

      before { allow(user).to receive(:permission_roles) { permission_roles } }

      context 'when user not have acls' do
        let(:permission_acls) { [] }

        it 'receives permission acls empty' do
          expect(subject.send(:permission?, :create?)).to be false
        end
      end

      context 'when user have acls' do
        let(:permission_acls) { [double(model: model, action: action)] }

        context 'when not have requested acl' do
          let(:model)  { nil }
          let(:action) { nil }

          it 'receives permission acls false' do
            expect(subject.send(:permission?, :create?)).to be false
          end
        end

        context 'when have requested acl' do
          let(:model)  { double.class.name.downcase }
          let(:action) { 'create' }

          it 'receives permission acls true' do
            expect(subject.send(:permission?, :create?)).to be true
          end
        end
      end
    end
  end

  describe 'Scope' do
    let(:scope) { double }

    subject { described_class::Scope.new(user, scope) }

    context '.initialize' do
      it 'receives user and scope' do
        expect(subject.instance_variable_get(:@user)).to eq(user)
        expect(subject.instance_variable_get(:@scope)).to eq(scope)
      end
    end

    context '.resolve' do
      it 'receives scope' do
        expect(subject).to receive(:scope)
        subject.resolve
      end
    end
  end
end
