require 'orocos'
require 'readline'

include Orocos
Orocos.initialize


Orocos.run 'sonar_tritech::Micron' => 'sonar_tritech', 
    'sonaroctomap::Task' => 'sonaroctomap' do
  
  sonar_tritech = Orocos.name_service.get 'sonar_tritech'


  sonaroctomap = Orocos.name_service.get 'sonaroctomap'
  
  # Never assume that a component supports being reconnected
  # at runtime, it might not be the case
  #
  # If you have the choice, connect before the component is
  # even configured
  sonar_tritech.sonar_beam.connect_to sonaroctomap.sonarBeamPort
  sonar_tritech.port = "/dev/ttyUSB0" 
  sonar_tritech.configure
  sonar_tritech.start
  sonaroctomap.start

  #Enable Logging
  Orocos.log_all
  Orocos.watch(sonar_tritech)

  

  
  Readline::readline("Press ENTER to exit\n") do
  end 
end
