shared_examples_for 'Metasploit::Model::Module::Instance' do
  context 'CONSTANTS' do
    context 'PRIVILEGES' do
      subject(:privileges) do
        described_class::PRIVILEGES
      end

      it 'should contain both Boolean values' do
        privileges.should include(false)
        privileges.should include(true)
      end
    end

    context 'STANCES' do
      subject(:stances) do
        described_class::STANCES
      end

      it { should include('aggressive') }
      it { should include('passive') }
    end
  end

  context 'search' do
    context 'search_i18n_scope' do
      subject(:search_i18n_scope) do
        described_class.search_i18n_scope
      end

      it { should == 'metasploit.model.module.instance' }
    end

    context 'associations' do
      it_should_behave_like 'search_association', :actions
      it_should_behave_like 'search_association', :architectures
      it_should_behave_like 'search_association', :authorities
      it_should_behave_like 'search_association', :authors
      it_should_behave_like 'search_association', :email_addresses
      it_should_behave_like 'search_association', :module_class
      it_should_behave_like 'search_association', :platforms
      it_should_behave_like 'search_association', :rank
      it_should_behave_like 'search_association', :references
      it_should_behave_like 'search_association', :targets
    end

    context 'attributes' do
      it_should_behave_like 'search_attribute', :description, :type => :string
      it_should_behave_like 'search_attribute', :disclosed_on, :type => :date
      it_should_behave_like 'search_attribute', :license, :type => :string
      it_should_behave_like 'search_attribute', :name, :type => :string
      it_should_behave_like 'search_attribute', :privileged, :type => :boolean
      it_should_behave_like 'search_attribute', :stance, :type => :string
    end
  end

  context 'validations' do
    context 'validate presence of module_class' do
      subject(:module_instance) do
        FactoryGirl.build(module_instance_factory, :module_class => module_class)
      end

      before(:each) do
        module_instance.valid?
      end

      context 'with module_class' do
        let(:module_class) do
          FactoryGirl.build(module_class_factory)
        end

        it 'should not record error on module_class' do
          module_instance.errors[:module_class].should be_empty
        end
      end

      context 'without module_class' do
        let(:module_class) do
          nil
        end

        it 'should record error on module_class' do
          module_instance.errors[:module_class].should include("can't be blank")
        end
      end
    end

    context 'ensure inclusion of privileged is boolean' do
      let(:error) do
        'is not included in the list'
      end

      before(:each) do
        module_instance.privileged = privileged

        module_instance.valid?
      end

      context 'with nil' do
        let(:privileged) do
          nil
        end

        it 'should record error' do
          module_instance.errors[:privileged].should include(error)
        end
      end

      context 'with false' do
        let(:privileged) do
          false
        end

        it 'should not record error' do
          module_instance.errors[:privileged].should be_empty
        end
      end

      context 'with true' do
        let(:privileged) do
          true
        end

        it 'should not record error' do
          module_instance.errors[:privileged].should be_empty
        end
      end
    end

    context 'stance' do
      context 'module_type' do
        subject(:module_instance) do
          FactoryGirl.build(
              module_instance_factory,
              :module_class => module_class,
              # set by shared examples
              :stance => stance
          )
        end

        let(:module_class) do
          FactoryGirl.create(
              module_class_factory,
              # set by shared examples
              :module_type => module_type
          )
        end

        let(:stance) do
          nil
        end

        it_should_behave_like 'Metasploit::Model::Module::Instance supports stance with module_type', 'auxiliary'
        it_should_behave_like 'Metasploit::Model::Module::Instance supports stance with module_type', 'exploit'

        it_should_behave_like 'Metasploit::Model::Module::Instance does not support stance with module_type', 'encoder'
        it_should_behave_like 'Metasploit::Model::Module::Instance does not support stance with module_type', 'nop'
        it_should_behave_like 'Metasploit::Model::Module::Instance does not support stance with module_type', 'payload'
        it_should_behave_like 'Metasploit::Model::Module::Instance does not support stance with module_type', 'post'
      end
    end
  end
end