require 'rails_helper'

describe ContactMailer do
  
  describe 'お問い合わせメール送信のテスト' do
    let(:contact) {
                    create(:contact,
                    name: 'テストメール',
                    email: 'test@example.com',
                    content: 'こちらはcontactmailer用のテストメールです')
                  }
    
    let(:text_body) do
      part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8' }
      part.body.raw_source
    end
    let(:html_body) do
      part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8' }
      part.body.raw_source
    end
    
    subject(:mail) do
      described_class.send_mail(contact).deliver_now
      ActionMailer::Base.deliveries.last
    end

    context '送信したメール内容が正しい' do
      it { expect(mail.from.first).to eq('test@example.com') }
      it { expect(mail.to.first).to eq('ee111fender@gmail.com') }
      
      # text形式の本文
      it { expect(text_body).to match('テストメール') }
      it { expect(text_body).to match('こちらはcontactmailer用のテストメールです') }
      
      # html形式の本文
      it { expect(html_body).to match('テストメール') }
      it { expect(html_body).to match('こちらはcontactmailer用のテストメールです') }
    end
  end
end