/* Generated from orogen/lib/orogen/templates/tasks/Task.cpp */

#include "Task.hpp"
#include <iostream>
#include <sonaroctomap/SonarOcTree.hpp>
#include <base/samples/SonarBeam.hpp>
#include <base/samples/RigidBodyState.hpp>

#include <octomap_wrapper/OctomapWrapper.hpp>
#include <octomap_wrapper/Conversion.hpp>

using namespace sonaroctomap;

Task::Task(std::string const& name, TaskCore::TaskState initial_state) :
		TaskBase(name, initial_state)

{
	sonarOcTree = new octomap::SonarOcTree(0.2);
	wrapper = new octomap_wrapper::OctomapWrapper();
}

Task::Task(std::string const& name, RTT::ExecutionEngine* engine,
		TaskCore::TaskState initial_state) :
		TaskBase(name, engine, initial_state)

{
	sonarOcTree = new octomap::SonarOcTree(0.2);
	wrapper = new octomap_wrapper::OctomapWrapper();

}

Task::~Task() {
	delete sonarOcTree;
}

/// The following lines are template definitions for the various state machine
// hooks defined by Orocos::RTT. See Task.hpp for more detailed
// documentation about them.

bool Task::configureHook() {
	if (!TaskBase::configureHook())
		return false;
	return true;
}
bool Task::startHook() {
	if (!TaskBase::startHook())
		return false;
	return true;
}
void Task::updateHook() {

	base::samples::SonarBeam sonarBeam;
	base::samples::RigidBodyState sonarState;
	_sonarBeamPort.readNewest(sonarBeam);

	if (sonarBeam.time.microseconds != 0) {
		sonarState.initUnknown();
// 		sonarOcTree->insertBeam(sonarBeam, sonarState);
		
		sonarOcTree->insertRealBeam(sonarBeam, sonarState);
		octomap::OcTree* tree = dynamic_cast<octomap::OcTree*>(sonarOcTree);

		octomap_wrapper::fullMapToMsg(*tree, *wrapper);
		//octomap_wrapper::binaryMapToMsg(*tree, *wrapper);

		_wrapperOutput.write(*wrapper);
	}

}
void Task::errorHook() {
	TaskBase::errorHook();
}
void Task::stopHook() {
	TaskBase::stopHook();
}
void Task::cleanupHook() {
	TaskBase::cleanupHook();
}
