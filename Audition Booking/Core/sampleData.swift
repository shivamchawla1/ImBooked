//
//  sampleData.swift
//  Audition Booking
//
//  Created by Apoorv Verma on 23/05/23.
//

import Foundation
import SwiftUI

let imageNames = ["main", "main 1", "main 2", "main 3", "main 4", "main 5", "main 6"]

let sampleEvents: [Event] = [
    Event(
        id: 1,
        userID: 0,
        castTitle: "Casting Title 1",
        breakdownTitle: "Breakdown Title 1",
        breakdownRightHeading: "Right Heading 1",
        breakdownLeftHeading: "Left Heading 1",
        additionalNotes: "Additional Notes 1",
        representation: "Representation 1",
        castingDirector: "Casting Director 1",
        isInPerson: "0",
        projectName: "Project Name 1",
        notes: "Some notes 1",
        instructions: "Some instructions 1",
        transmissionCost: "Transmission Cost 1",
        role: "Role 1",
        roleDescription: "Role Description 1",
        payScale: "Pay Scale 1",
        auditionDue: "2023-07-01",
        startTime: "19:00:00",
        endTime: "05:30:00",
        callBack: "2023-07-02",
        wardrobeFitting: "2023-06-30",
        isCovidTestDone: "0",
        shootWindow: "2023-07-05 to 2023-07-07",
        shootLocation: "Shoot Location 1",
        isComplete: 0, media: [],
        notify: "0",
        createdAt: "Notify 1",
        updatedAt: "2023-06-23 10:00 AM",
        images: [
            "https://quantumhostings.com/projects/audition/public/storage/auditions_data/SF4D2piXUh1GW6WiLelle9g7QT4qJQlYcTEInfpm.png",
            "https://quantumhostings.com/projects/audition/public/storage/auditions_data/Lgmry6BAXS9qltBSzDvd5XAL1C6xo3P7bckxW2VZ.png",
            "https://quantumhostings.com/projects/audition/public/storage/auditions_data/AaFKrtMDlZuDaWWdeD0SOOR0ePo2r7LRFHphrIBV.png",
            "https://quantumhostings.com/projects/audition/public/storage/auditions_data/wtDQldC3J9chmtENKqC1cpZnsWFOHQOUaumSZ2Gf.png",
            "https://quantumhostings.com/projects/audition/public/storage/auditions_data/Tot43vJoQGwJOsWUOlZ2wtHJTnjAIiqmnD28Ff1B.png"
        ],
        videos: [ "https://quantumhostings.com/projects/audition/public/storage/auditions_data/iuiYVzc7YN9CzIXLCUjYg8GFfzrxVuZBm89DJe3H.mp4"],
        eventColor: "#C7D2FE",
        marksAsCallback: "1",
        notifyMeAt: "30",
        invitationType: "0",
        shootWindowEndDate : ""
    ),
    Event(
        id:2,
        userID: 0,
        castTitle: "Casting Title 1",
        breakdownTitle: "Breakdown Title 1",
        breakdownRightHeading: "Right Heading 1",
        breakdownLeftHeading: "Left Heading 1",
        additionalNotes: "Additional Notes 1",
        representation: "Representation 1",
        castingDirector: "Casting Director 1",
        isInPerson: "0",
        projectName: "Project Name 1",
        notes: "Some notes 1",
        instructions: "Some instructions 1",
        transmissionCost: "Transmission Cost 1",
        role: "Role 1",
        roleDescription: "Role Description 1",
        payScale: "Pay Scale 1",
        auditionDue: "2023-07-01",
        startTime: "19:00:00",
        endTime: "05:30:00",
        callBack: "2023-07-02",
        wardrobeFitting: "2023-06-30",
        isCovidTestDone: "0",
        shootWindow: "2023-07-05 to 2023-07-07",
        shootLocation: "Shoot Location 1",
        isComplete: 0, media: [],
        notify: "0",
        createdAt: "Notify 1",
        updatedAt: "2023-06-23 10:00 AM",
        images: [
            "https://quantumhostings.com/projects/audition/public/storage/auditions_data/SF4D2piXUh1GW6WiLelle9g7QT4qJQlYcTEInfpm.png",
            "https://quantumhostings.com/projects/audition/public/storage/auditions_data/Lgmry6BAXS9qltBSzDvd5XAL1C6xo3P7bckxW2VZ.png",
            "https://quantumhostings.com/projects/audition/public/storage/auditions_data/AaFKrtMDlZuDaWWdeD0SOOR0ePo2r7LRFHphrIBV.png",
            "https://quantumhostings.com/projects/audition/public/storage/auditions_data/wtDQldC3J9chmtENKqC1cpZnsWFOHQOUaumSZ2Gf.png",
            "https://quantumhostings.com/projects/audition/public/storage/auditions_data/Tot43vJoQGwJOsWUOlZ2wtHJTnjAIiqmnD28Ff1B.png"
        ],
        videos: [ "https://quantumhostings.com/projects/audition/public/storage/auditions_data/iuiYVzc7YN9CzIXLCUjYg8GFfzrxVuZBm89DJe3H.mp4"],
        eventColor: "#C7D2AA",
        marksAsCallback: "1",
        notifyMeAt: "30",
        invitationType: "0",
        shootWindowEndDate : ""
    )
]

let sampleContacts = [
    Contact(
        name: "John Appleseed",
        number: ["(123) 456-7890", "(555) 678-9012"],
        email: "john@appleseed.com",
        company: "Apple",
        shootLocations: ["Los Angeles", "New York"],
        notes: "Great photographer!",
        isVirtual: true
    ),
    Contact(
        image: Image("SampleImage"),
        name: "Jane Doe",
        number: ["(123) 456-7891", "(555) 678-9013"],
        email: "jane@doe.com",
        company: "Google",
        shootLocations: ["San Francisco", "Mountain View"],
        notes: "Excellent writer!",
        isVirtual: false
    ),
    Contact(
        image: Image("SampleImage"),
        name: "Bill Gates",
        number: ["(123) 456-7892", "(555) 678-9014"],
        email: "bill@gates.com",
        company: "Microsoft",
        shootLocations: ["Redmond", "Seattle"],
        notes: "Legendary businessman!",
        isVirtual: true
    ),
    Contact(
        name: "Steve Jobs",
        number: ["(123) 456-7893", "(555) 678-9015"],
        email: "steve@jobs.com",
        company: "Apple",
        shootLocations: ["Los Angeles", "New York"],
        notes: "Co-founder of Apple!",
        isVirtual: true
    ),
    Contact(
        image: Image("SampleImage"),
        name: "Elon Musk",
        number: ["(123) 456-7894", "(555) 678-9016"],
        email: "elon@musk.com",
        company: "Tesla",
        shootLocations: ["Los Angeles", "Austin"],
        notes: "CEO of Tesla and SpaceX!",
        isVirtual: false
    ),
    Contact(
        image: Image("SampleImage"),
        name: "Jeff Bezos",
        number: ["(123) 456-7895", "(555) 678-9017"],
        email: "jeff@bezos.com",
        company: "Amazon",
        shootLocations: ["Seattle", "Austin"],
        notes: "CEO of Amazon!",
        isVirtual: true
    ),
    Contact(
        image: Image("SampleImage"),
        name: "Mark Zuckerberg",
        number: ["(123) 456-7896", "(555) 678-9018"],
        email: "mark@zuckerberg.com",
        company: "Meta",
        shootLocations: ["Menlo Park", "Austin"],
        notes: "CEO of Meta!",
        isVirtual: true
    ),
    Contact(
        image: Image("SampleImage"),
        name: "Larry Page",
        number: ["(123) 456-7897", "(555) 678-9019"],
        email: "larry@page.com",
        company: "Google",
        shootLocations: ["Mountain View", "Austin"],
        notes: "Co-founder of Google!",
        isVirtual: true
    ),
    Contact(
        image: Image("SampleImage"),
        name: "Sergey Brin",
        number: ["(123) 456-7898", "(555) 678-9020"],
        email: "sergey@brin.com",
        company: "Google",
        shootLocations: ["Mountain View", "Austin"],
        notes: "Co-founder of Google!",
        isVirtual: false
    )
]
