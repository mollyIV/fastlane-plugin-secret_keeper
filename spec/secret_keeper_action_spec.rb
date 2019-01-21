describe Fastlane::Actions::SecretKeeperAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The secret_keeper plugin is working!")

      Fastlane::Actions::SecretKeeperAction.run(nil)
    end
  end
end
