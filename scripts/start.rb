require 'orocos'
include Orocos

## Initialize orocos ##
Orocos.initialize

## Execute the task 'message_producer::Task' ##
Orocos.run 'sonaroctomap::Task' => 'sonaroctomap' do
  ## Get the task context##
  sonaroctomap = Orocos.name_service.get 'sonaroctomap'
  
  ## Start the tasks ##
  sonarBeamPort = sonaroctomap.sonarBeamPort.writer
	
  sonaroctomap.start

  sonarBeam = sonarBeamPort.new_sample
  sonarBeam.speed_of_sound = 1.0
  sonarBeam_Port.write(sonarBeam)  
 
 
end
