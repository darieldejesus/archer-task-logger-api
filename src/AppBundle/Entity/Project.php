<?php

namespace AppBundle\Entity;

use ApiPlatform\Core\Annotation\ApiResource;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * A Project of a Customer.
 *
 * @ApiResource(itemOperations={
 *     "get"={"method"="GET"},
 *     "put"={"method"="PUT"}
 * })
 * @ORM\Entity
 */

class Project
{
    /**
     * @var int The id of this project.
     * 
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @var string The name of this project.
     * 
     * @ORM\Column
     * @Assert\NotBlank
     */
    private $name;

    /**
     * @var string The URL of the project board.
     * 
     * @ORM\Column
     * @Assert\Url
     */
    private $url;

    /**
     * @var int The status of this project.
     * 0 = Deleted
     * 1 = Active
     * 2 = Inactive
     * 
     * @ORM\Column(type="smallint")
     * @Assert\Range(min=0, max=2)
     * @Assert\NotNull
     */
    private $status;

    /**
     * @var Customer The customer (owner) of this project.
     * 
     * @Assert\NotNull
     * @ORM\ManyToOne(targetEntity="Customer", inversedBy="projects")
     */
    private $customer;

    /**
     * @var Task[] The tasks that belong to this project.
     * 
     * @ORM\OneToMany(targetEntity="Task", mappedBy="project")
     */
    private $tasks;

    /**
     * @var User[] The users that belong to this project.
     *
     * @ORM\ManyToMany(targetEntity="User", mappedBy="projects")
     */
    private $users;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->tasks = new \Doctrine\Common\Collections\ArrayCollection();
        $this->users = new \Doctrine\Common\Collections\ArrayCollection();
    }

    /**
     * Get id
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set name
     *
     * @param string $name
     *
     * @return Project
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Get name
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set url
     *
     * @param string $url
     *
     * @return Project
     */
    public function setUrl($url)
    {
        $this->url = $url;

        return $this;
    }

    /**
     * Get url
     *
     * @return string
     */
    public function getUrl()
    {
        return $this->url;
    }

    /**
     * Set status
     *
     * @param integer $status
     *
     * @return Project
     */
    public function setStatus($status)
    {
        $this->status = $status;

        return $this;
    }

    /**
     * Get status
     *
     * @return integer
     */
    public function getStatus()
    {
        return $this->status;
    }

    /**
     * Set customer
     *
     * @param \AppBundle\Entity\Customer $customer
     *
     * @return Project
     */
    public function setCustomer(\AppBundle\Entity\Customer $customer = null)
    {
        $this->customer = $customer;

        return $this;
    }

    /**
     * Get customer
     *
     * @return \AppBundle\Entity\Customer
     */
    public function getCustomer()
    {
        return $this->customer;
    }

    /**
     * Add task
     *
     * @param \AppBundle\Entity\Task $task
     *
     * @return Project
     */
    public function addTask(\AppBundle\Entity\Task $task)
    {
        $this->tasks[] = $task;

        return $this;
    }

    /**
     * Remove task
     *
     * @param \AppBundle\Entity\Task $task
     */
    public function removeTask(\AppBundle\Entity\Task $task)
    {
        $this->tasks->removeElement($task);
    }

    /**
     * Get tasks
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getTasks()
    {
        return $this->tasks;
    }

    /**
     * Add user
     *
     * @param \AppBundle\Entity\User $user
     *
     * @return Project
     */
    public function addUser(\AppBundle\Entity\User $user)
    {
        $this->users[] = $user;

        return $this;
    }

    /**
     * Remove user
     *
     * @param \AppBundle\Entity\User $user
     */
    public function removeUser(\AppBundle\Entity\User $user)
    {
        $this->users->removeElement($user);
    }

    /**
     * Get users
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getUsers()
    {
        return $this->users;
    }
}
