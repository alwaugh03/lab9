# README

This README documents the steps necessary to get the
application up and running.

### Setup
```bash

* libvips, action_text is required as a system dependency for image variants, installation is done with sudo apt update,
sudo apt install libvips and bin/rails action_text:install, bin/rails db:migrate

*Database setup and seading with
bin/rails db:drop db:create db:migrate db:seed

* run the app with
bin/rails server.
```

### Capabilities

* sanitization check results in no alerts deployed and the text shown as is without runing the code

* This application uses Devise for user authentication. All resource pages require a signed-in user, including:

- Owners
- Pets
- Vets
- Appointments
- Treatments

The home page remains publicly accessible.

## Role-Based Access Control Matrix

| Resource / Action|   Admin   |                    Vet                    |                      Owner                     |
|------------------|-----------|-------------------------------------------|------------------------------------------------|
| **Owner**        | Full CRUD | Read-only (all owners)                    | Read-only (own record only) + edit/update self |
| **Pet**          | Full CRUD | Read-only                                 | Full CRUD (own pets only)                      |
| **Vet**          | Full CRUD | Read-only (all vets) + edit/update self   | Read-only                                      |
| **Appointment**  | Full CRUD | Full CRUD (only assigned appointments)    | Full CRUD (own pets only)                      |
| **Treatment**    | Full CRUD | Full CRUD (only for assigned appointments)| Read-only (via appointment only)               |


### Seeded Users (Role, First Name, Last Name, Email)

*some of the Owners dont have users for the purpuse of proving admin privileges, the following are all users and their passwords

Admin	Admin   User   admin@vetclinic.com password123
Vet	    Vet  User	   vet@vetclinic.com password123
Vet	    Second  Vet	   vet2@vetclinic.com password123
Owner	Owner  User  owner@vetclinic.com password123
Owner	Maria  Owner  owner2@vetclinic.com password123




