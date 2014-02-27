/* Generated from orogen/lib/orogen/templates/tasks/Task.cpp */

#include "Task.hpp"
#include <octomap/math/Pose6D.h>
#include <octomap/math/Quaternion.h>
#include <octomap/math/Utils.h>
#include <octomap/math/Vector3.h>
#include <octomap/octomap.h>



using namespace sonaroctomap;

Task::Task(std::string const& name)
    : TaskBase(name)
	, octree(0)
{
	octree = new octomap::OcTree(0.1);
}

Task::Task(std::string const& name, RTT::ExecutionEngine* engine)
    : TaskBase(name, engine)
	, octree(0)
{
	octree = new octomap::OcTree(0.1);

}

Task::~Task()
{
	delete octree;
}



/// The following lines are template definitions for the various state machine
// hooks defined by Orocos::RTT. See Task.hpp for more detailed
// documentation about them.

bool Task::configureHook()
{
    if (! TaskBase::configureHook())
        return false;
    return true;
}
bool Task::startHook()
{
    if (! TaskBase::startHook())
        return false;
    return true;
}
void Task::updateHook()
{
    TaskBase::updateHook();
    base::samples::SonarBeam sonarBeam;

    _sonarBeamPort.readNewst(sonarBeam);

    if(sonarBeam.speed_of_sound == 1.0){
    	std::cout << "funfa!"  << std::endl;
    }
}
void Task::errorHook()
{
    TaskBase::errorHook();
}
void Task::stopHook()
{
    TaskBase::stopHook();
}
void Task::cleanupHook()
{
    TaskBase::cleanupHook();
}
