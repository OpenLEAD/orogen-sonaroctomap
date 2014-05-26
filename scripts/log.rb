require 'orocos'
require 'readline'
#library for displaying data
require 'vizkit'


include Orocos
Orocos.initialize

#load log file 
log = Orocos::Log::Replay.open("sonar_tritech.0.log")

#now you can access all logged data by 
#addressing them by their task and port name
#log.task_name.port_name

#start deployment
Orocos.run 'sonaroctomap::Task' => 'sonaroctomap' do
  sonaroctomap = Orocos.name_service.get 'sonaroctomap'  
  log.sonar_tritech.sonar_beam.connect_to sonaroctomap.sonarBeamPort
  sonaroctomap.start
  
    #open control widget and start replay
    Vizkit.control log
    Vizkit.exec

  
  Readline::readline("Press ENTER to exit\n") do
  end 
end
