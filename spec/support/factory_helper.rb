module FactoryHelper
  TEXT_BODIES = [
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aperiam cupiditate quibusdam nulla nobis, recusandae velit, commodi non amet delectus saepe doloribus cum ratione est excepturi porro a consectetur aliquam iste!',
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nam in quas facilis possimus deleniti blanditiis mollitia et quam nisi, maiores labore est. Nemo ducimus non, velit explicabo libero maiores facilis!',
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloribus omnis maxime ducimus officiis magni quas dolore odio minus harum iusto, cumque dolorum mollitia sequi, facere voluptatem temporibus laboriosam placeat non?',
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reprehenderit laboriosam, atque. Esse non fuga laudantium iure quo sint inventore mollitia provident nisi beatae quod atque, voluptatum, hic maxime maiores sunt.',
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium provident repudiandae qui harum, corporis repellendus illo impedit voluptatum rem nulla quae est aspernatur minus quam nesciunt doloremque fuga sequi culpa.',
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eveniet accusamus, veritatis fuga id nam corrupti quis quos inventore, perspiciatis ab! Fugiat animi, qui doloribus aut quas enim dignissimos libero dolorum?'
  ]

  FIRST_NAMES = [
    'Moe',
    'Larry',
    'Curly',
    'Elmer',
    'Mickey',
    'Daffy',
    'Bugs',
    'Porky',
    'Minnie',
    'Tom',
    'Jerry'
  ]
  LAST_NAMES = [
    'Fud',
    'Mouse',
    'Duck',
    'Bunny',
    'Pig',
    'Cat'
  ]
  PASSWORD = 'password'

  COLLEGES = [
    'School Academy',
    'College University',
    'We Don\'t Need No Education'
  ]

  HOMETOWNS = [
    'Townville, USA',
    'Winchestertonfieldville, England',
    'The Abyss, Vortex',
    'Outerspace, Neptune'
  ]

  TELEPHONES = [
    '1-123-123-1234',
    '1 (123) 123-1234',
    '234 234 1234',
    '+1 (123) 123-1234',
    '867-5309'
  ]

  def self.first_name(n=0)
    FIRST_NAMES[n % FIRST_NAMES.length]
  end

  def self.last_name(n=0)
    LAST_NAMES[n % LAST_NAMES.length]
  end

  def self.email(n=0)
    "#{first_name(n).downcase}-#{n}@#{last_name(n).downcase}.com"
  end

  def self.college(n=0)
    COLLEGES[n % COLLEGES.length]
  end

  def self.hometown(n=0)
    HOMETOWNS[n % HOMETOWNS.length]
  end

  def self.telephone(n=0)
    TELEPHONES[n % TELEPHONES.length]
  end

  def self.text(n=0)
    TEXT_BODIES[n % TEXT_BODIES.length]
  end
end


