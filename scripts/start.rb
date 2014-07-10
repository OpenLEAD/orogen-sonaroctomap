require 'orocos'
include Orocos

## Initialize orocos ##
Orocos.initialize

## Execute the task 'message_producer::Task' ##
Orocos.run 'sonaroctomap::Task' => 'sonaroctomap' do
  ## Get the task context##
  sonaroctomap = Orocos.name_service.get 'sonaroctomap'
  ## Create a sample writer for a port ##
  sonarBeamPort = sonaroctomap.sonarBeamPort.writer
  ## Start the tasks ##
  

  #sonarBeam = Types::Base::SonarBeam.new
  sonarBeam = sonarBeamPort.new_sample
  sonarBeam.speed_of_sound = 1.0
  sonarBeam.time =Types::Base::Time.new
  sonarBeam.bearing.rad = 0.0
  sonarBeam.sampling_interval = 1.0
  sonarBeam.beamwidth_vertical = 0.610865238
  sonarBeam.beamwidth_horizontal = 0.052359878
  #std::vector < uint8_t > bins(10)
  sonarBeam.beam = [15,25,35,45,55,65,75,85,95,100]

  sonaroctomap.start
  while true
    sonarBeamPort.write(sonarBeam) 
    sonarBeam.bearing.rad =  sonarBeam.bearing.rad + 5*0.0174532925
   sleep 0.1
  end
  
  
 
end
