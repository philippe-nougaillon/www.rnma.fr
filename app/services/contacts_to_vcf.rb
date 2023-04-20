class ContactsToVcf < ApplicationService
    require 'vcardigan'

    attr_reader :contacts

    def initialize(contacts)
        @contacts = contacts
    end

    def call
        vcards = []
        @contacts.each do | contact |
            # création d'une vCARD
            vcard = VCardigan.create(:version => '4.0')
            vcard.fullname contact.prénom + ' ' + contact.nom
            vcard.tel contact.téléphone, :type => 'work'
            vcard.email contact.email, :type => 'work'
            vcard.org contact.maison_organisation
            vcard.title contact.fonction
            if contact.maison
                vcard.adr [contact.maison.adresse, contact.maison.cp, contact.maison.ville].join(';')
            end
            vcards << vcard.to_s
        end
        vcards.flatten
    end

end
