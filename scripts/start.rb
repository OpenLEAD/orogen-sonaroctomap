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
  sonarBeam.beam = [1,2,3,4,5,6,7,8,9,10]

  sonaroctomap.start
  while true
    sonarBeamPort.write(sonarBeam)  
   sleep 1.0
  end
  sonarBeamPort.write(sonarBeam)  
  
 
end
