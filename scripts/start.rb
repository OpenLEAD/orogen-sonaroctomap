require 'orocos'
include Orocos

## Initialize orocos ##
Orocos.initialize

## Execute the task 'message_producer::Task' ##
Orocos.run 'sonaroctomap::Task' => 'sonaroctomap' do
  ## Get the task context##
  sonaroctomap = Orocos.name_service.get 'sonaroctomap'
  
  ## Start the tasks ##
  sonaroctomap.start

  sonarBeamPort = sonaroctomap.sonarBeamPort.writer

  sonarBeam = sonarBeamPort.new_sample
  sonarBeam.speed_of_sound = 2.0
  sonarBeamPort.write(sonarBeam)  
 
 
end
