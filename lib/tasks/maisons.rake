namespace :maisons do

    desc "Importer les maisons et les données associées"
    task importer: :environment do

        Spreadsheet.client_encoding = 'UTF-8'
        book = Spreadsheet.open 'db/import ADHERENTS 2021.xls'
        sheet1 = book.worksheet 0
        headers = %w(   NOM_structure	
                        Nom_officiel	
                        type	
                        cotisation	
                        Adresse	
                        CP	
                        VILLE	
                        Région_RNMA	
                        Téléphone_accueil	
                        Mail_accueil_1	
                        Mail_accueil_2	
                        Site	
                        Facebook	
                        Twitter	
                        Linkedin	
                        Youtube	
                        abonnement_NL	
                        Contacts	
                        Fonction	
                        Mail	
                        téléphone1	
                        téléphone2	
                        tag1	
                        tag2	
                        tag3 
                    )

        index   = 0
        errors  = 0

        sheet1.each 1 do |row|
            next unless row[1]

            #puts row

            maison = Maison.where(nom: row[headers.index 'Nom_officiel']).first_or_initialize do |m|
                m.type_structure = row[headers.index 'type']               
                m.adresse = row[headers.index 'Adresse']                
                m.cp = row[headers.index 'CP']                
                m.ville = row[headers.index 'VILLE']                
                m.téléphone = row[headers.index 'Téléphone_accueil'].gsub('.', ' ')                
                m.email = row[headers.index 'Mail_accueil_1']                
                m.site = row[headers.index 'Site']  
                m.linkedin = row[headers.index 'Linkedin']
                m.youtube = row[headers.index 'Youtube']
                m.facebook = row[headers.index 'Facebook']
                m.twitter = row[headers.index 'Twitter']
                m.newsletter = row[headers.index 'abonnement_NL']
            end

            puts maison.inspect

            if maison.new_record?
                puts '_* ' * 60
                if maison.save
                    puts "[Import OK] Maison importée"
                else
                    puts "[ERREUR] #{ maison.errors.messages }"
                    errors += 1
                    next
                end    

                adhésion = Adhesion.new(maison_id: maison.id, 
                                        organisme: maison.nom, 
                                        type_structure: maison.type_structure,
                                        email: maison.email,
                                        adresse: maison.adresse,
                                        cp: maison.cp,
                                        ville: maison.ville,
                                        workflow_state: 'validée')

                puts adhésion.inspect
                if adhésion.save
                    puts "[Import OK] Adhésion créée"
                else
                    puts "[ERREUR] #{ adhésion.errors.messages }"
                    errors += 1
                end

                cotisation = adhésion.cotisations
                                     .new(  période: '2021', 
                                            montant: row[headers.index 'cotisation'] ? row[headers.index 'cotisation'] : 0,
                                            workflow_state: 'réglée')

                puts cotisation.inspect
                if cotisation.save
                    puts "[Import OK] Cotisation créée"
                else
                    puts "[ERREUR] #{ cotisation.errors.messages }" 
                    errors += 1
                end
            end

            _téléphone = row[headers.index 'téléphone1'] ? row[headers.index 'téléphone1'].gsub('.', ' ') : nil
            _mobile = row[headers.index 'téléphone2'] ? row[headers.index 'téléphone2'].gsub('.', ' ') : nil

            contact = maison.contacts
                            .new(nom: row[headers.index 'Contacts'].split(' ').last.upcase, 
                                prénom: row[headers.index 'Contacts'].split(' ').first,
                                fonction: row[headers.index 'Fonction'],
                                email: row[headers.index 'Mail'],
                                téléphone: _téléphone,
                                mobile: _mobile,
                                adresse: maison.adresse,
                                cp: maison.cp,
                                ville: maison.ville
                            )

            contact.tag_list.add(row[headers.index 'tag1'].upcase) unless row[headers.index 'tag1'].blank?
            contact.tag_list.add(row[headers.index 'tag2'].upcase) unless row[headers.index 'tag2'].blank?
            contact.tag_list.add(row[headers.index 'tag3'].upcase) unless row[headers.index 'tag3'].blank?
            
            # Vérifier qu'il n'y ait pas déjà un contact ayant le même email
            unless contact.email.blank?
                if doublon = Contact.find_by(email: contact.email)
                    tag = 'Doublon email'
                    contact.tag_list.add(tag)
                    doublon.tag_list.add(tag)
                    doublon.save 
                end
            end
            
            puts contact.inspect
            
            if contact.save
                puts "[Import OK] contact créée"
            else
                puts "[ERREUR] #{ contact.errors.messages }" 
                errors += 1
            end

            index += 1

            puts '* - ' * 20
            puts "[Import OK] import ##{ index } terminé ! #{ errors } erreurs."
            puts '* - ' * 20

        end

    end

    desc "Remise à zéro des Maisons et données associées"
    task raz: :environment do
        Cotisation.destroy_all
        Adhesion.destroy_all
        Contact.destroy_all
        Maison.destroy_all
    end

end  