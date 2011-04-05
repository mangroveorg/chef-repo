maintainer       "YOUR_COMPANY_NAME"
maintainer_email "YOUR_EMAIL"
license          "All rights reserved"
description      "Installs/Configures mangroveapp"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

depends           "python"

recipe "mangrove", "Install the mangrove application"

%w{ debian ubuntu centos redhat fedora }.each do |os|
  supports os
end
