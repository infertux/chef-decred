control 'dcrd-1' do
  title 'dcrd'
  impact 1.0

  describe command('sudo -iu decred -- dcrd --version') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/\Adcrd version 1\.1\.0\+release/) }
  end

  describe processes('dcrd') do
    its('entries.length') { should eq 1 }
    its('users') { should eq ['decred'] }
  end

  describe file('/home/decred/.dcrd/logs/mainnet/dcrd.log') do
    it { should be_file }
  end

  describe port(9108) do
    it { should_not be_listening }
  end

  describe port(9109) do
    it { should be_listening }
    its('protocols') { should cmp 'tcp' }
    its('addresses') { should cmp %w[127.0.0.1] }
  end
end
