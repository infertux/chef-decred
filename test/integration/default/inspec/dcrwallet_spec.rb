control 'dcrwallet-1' do
  title 'dcrwallet'
  impact 1.0

  describe processes('dcrwallet') do
    its('entries.length') { should eq 1 }
    its('users') { should eq ['decred'] }
  end

  describe file('/home/decred/.dcrwallet/logs/mainnet/dcrwallet.log') do
    it { should be_file }
  end

  describe port(9110) do
    it { should be_listening }
    its('protocols') { should cmp 'tcp' }
    its('addresses') { should cmp %w[127.0.0.1] }
  end

  describe port(9111) do
    it { should be_listening }
    its('protocols') { should cmp 'tcp' }
    its('addresses') { should cmp %w[127.0.0.1] }
  end
end
