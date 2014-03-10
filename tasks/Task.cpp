/* Generated from orogen/lib/orogen/templates/tasks/Task.cpp */

#include "Task.hpp"
#include <octomap/octomap.h>
#include <iostream>
#include "sonaroctomap/SonarOcTree.h"



using namespace sonaroctomap;

Task::Task(std::string const& name,TaskCore::TaskState initial_state)
    : TaskBase(name, initial_state)

{
	octree = new octomap::OcTree(0.1);
}

Task::Task(std::string const& name, RTT::ExecutionEngine* engine,TaskCore::TaskState initial_state)
    : TaskBase(name, engine, initial_state)

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

    _sonarBeamPort.read(sonarBeam);


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
