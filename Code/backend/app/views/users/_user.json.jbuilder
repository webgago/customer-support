return unless user

json.extract! user,
              :id,
              :email,
              :first_name,
              :last_name,
              :full_name,
              :role
